import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../screens/capture_screen.dart';

import '../Widgets/primaryButton.dart';
import '../Widgets/secondaryButton.dart';
import '../learnTextRecognition/text_recognition.dart';
import '../utilis/theme.dart';
import '../utilis/utilWidgets.dart';
import 'input_image.dart';
import 'input_image_data.dart';
import 'shared.dart';
// import '../Widgets/secondaryButton.dart';
// import '../utilis/utilWidgets.dart';

enum InputCameraMode { live, gallery }

enum InputCameraType { front, rear }

class InputCameraView extends StatefulWidget {
  InputCameraView({
    Key? key,
    required this.title,
    this.overlay,
    this.mode = InputCameraMode.gallery,
    this.cameraDefault = InputCameraType.rear,
    this.resolutionPreset = ResolutionPreset.low,
    this.canSwitchMode = true,
    // required this.image,
    this.action,
    this.onTapAction,
    // required this.onImage,
    required this.onSave,
  }) : super(key: key);

  final String title;
  final Widget? overlay;
  final InputCameraMode mode;
  final InputCameraType cameraDefault;
  final ResolutionPreset resolutionPreset;
  final bool canSwitchMode;
  final String? action;
  final void Function()? onTapAction;
  // final Function(InputImage inputImage) onImage;
  final Function(int total, String category, File? imageFile) onSave;

  @override
  _InputCameraViewState createState() => _InputCameraViewState();
}

class _InputCameraViewState extends State<InputCameraView> {
  final TextEditingController _totalTextController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  InputCameraMode _mode = InputCameraMode.live;
  CameraController? _controller;
  File? _image;
  ImagePicker? _imagePicker;
  int _cameraIndex = 0;

  String _dropDownValue = 'Fuel';

  var _dropItems = ["Grocery", "Medical", "Food", "Fuel", "Others"];

  CameraDescription get camera => cameras[_cameraIndex];
  bool get _isLive => _mode == InputCameraMode.live;
  bool get _hasAction => widget.action != null;
  bool get _showAction => _hasAction && _image != null;

  @override
  void initState() {
    _mode = widget.mode;
    super.initState();

    _imagePicker = ImagePicker();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeCamera();
      if (_isLive) await _startLiveStream();
      _refresh();
    });
    _takePhoto();
  }

  @override
  void dispose() {
    _stopLiveStream();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    if (cameras.length > 1 && widget.cameraDefault == InputCameraType.front) {
      _cameraIndex = 1;
    }
  }

  Future<void> _startLiveStream() async {
    _controller = CameraController(
      camera,
      widget.resolutionPreset,
      enableAudio: false,
    );

    await _controller?.initialize();
    _controller?.startImageStream(_processImage);
    _refresh();
  }

  Future<void> _stopLiveStream() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future<void> _chooseImage() async {
    await _getImage(ImageSource.gallery);
  }

  Future<void> _takePhoto() async {
    await _getImage(ImageSource.camera);
  }

  Future<void> _getImage(ImageSource source) async {
    XFile? xfile = await _imagePicker?.pickImage(source: source);

    if (xfile != null) {
      File image = new File(xfile.path);

      setState(() {
        _image = image;
      });

      final img = await decodeImageFromList(image.readAsBytesSync());

      _startRecognition(InputImage.fromFile(image,
          metadata: InputImageData(
            size: Size(img.width.toDouble(), img.height.toDouble()),
          )));
    }

    _refresh();
  }

  Future<void> _processImage(CameraImage image) async {
    InputImageRotation rotation = InputImageRotation.ROTATION_0;

    switch (camera.sensorOrientation) {
      case 0:
        rotation = InputImageRotation.ROTATION_0;
        break;
      case 90:
        rotation = InputImageRotation.ROTATION_90;
        break;
      case 180:
        rotation = InputImageRotation.ROTATION_180;
        break;
      case 270:
        rotation = InputImageRotation.ROTATION_270;
        break;
    }

    WriteBuffer writer = WriteBuffer();

    for (Plane plane in image.planes) {
      writer.putUint8List(plane.bytes);
    }

    Uint8List bytes = writer.done().buffer.asUint8List();

    InputImage inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
      ),
    );

    _startRecognition(inputImage);
    // widget.onImage(inputImage);
  }

  Future<void> _startRecognition(InputImage image) async {
    TextRecognition? _textRecognition = TextRecognition();
    TextRecognitionState state =
        Provider.of<TextRecognitionState>(context, listen: false);

    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = image;
      state.data = await _textRecognition?.process(image);
      print("##############" + state.data!.text);
      int total = findTotal(state.data!.text);
      print("Here Here");
      String tot = total.toString();
      setState(() {
        _totalTextController.text = tot;
      });
      print(tot);
      state.stopProcessing();
    }
  }

  void _handleSave() {
    widget.onSave(int.parse(_totalTextController.text),
        "${_dropDownValue.toLowerCase()}", this._image);
  }

  Widget get _imagePreview => Center(
        child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width * 0.97,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.file(_image!),
              widget.overlay ?? Container(),
            ],
          ),
        ),
      );

  Widget get _imageSvg => Center(
        child: SvgPicture.asset(
          'packages/learning_input_image/assets/image.svg',
          width: 200,
          height: 200,
          color: Colors.blueGrey[100],
        ),
      );

  Widget get _flipSvg => SvgPicture.asset(
        'packages/learning_input_image/assets/flip_camera.svg',
        width: 48,
        height: 48,
      );

  Widget get _galerySvg => SvgPicture.asset(
        'packages/learning_input_image/assets/gallery.svg',
        width: 32,
        height: 32,
        color: Colors.white,
      );

  Widget get _cameraSvg => SvgPicture.asset(
        'packages/learning_input_image/assets/camera.svg',
        width: 32,
        height: 32,
        color: Colors.white,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 1),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.73,
                child: _image == null ? _imageSvg : _imagePreview,
              ),
            ),
            addHorizontalSpace(32),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SecondaryButton(
                        icon: const Icon(
                          CupertinoIcons.camera,
                          color: colorWhite,
                        ),
                        name: "Retake",
                        onPressed: _takePhoto),
                    SecondaryButton(
                        icon: const Icon(
                          CupertinoIcons.folder,
                          color: colorWhite,
                        ),
                        name: "Gallery",
                        onPressed: _chooseImage)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 180,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                        // Initial Value
                        value: _dropDownValue,
                        underline: Container(
                          height: 2,
                          color: colorSecondary,
                        ),
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: _dropItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropDownValue = newValue!;
                          });
                        },
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        width: 180,
                        child: TextField(
                          controller: _totalTextController,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: PrimaryButton(
          name: "SAVE",
          icon: const Icon(
            CupertinoIcons.down_arrow,
            size: 24,
          ),
          onPressed: _handleSave),
    );
  }
}

int count = 0;

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

int findTotal(String text) {
  List<String> textLines = text.split('\n');
  List<int> amounts = [];

  for (String str in textLines) {
    str = str.replaceAll(". ", ".");
    var lstr = str.split(" ");
    for (String str2 in lstr) {
      if (isNumeric(str2)) {
        var num = double.parse(str2).toInt();
        if (num > 10000 || num <= 10) continue;
        amounts.add(num);
      }
    }
  }
  print(amounts.toString());
  HashMap<int, int> num_map = new HashMap();

  for (int num in amounts) {
    count = 0;
    var tmp = [...amounts];
    tmp.remove(num);
    sum_up(tmp, num);
    if (count > 0) {
      num_map[num] = count;
      // print(num);
    }
  }
  print(num_map.toString());

  int highestcount = 0;
  int highest = 0;
  for (int x in num_map.keys) {
    if (num_map[x]! > highestcount) {
      highest = x;
      highestcount = num_map[x]!;
    }
  }
  print('Highest: ' + highest.toString());
  return highest;
}

void sum_up_recursive(List<int> numbers, int target, List<int> partial) {
  int target1 = target - (target * 0.05).toInt();
  int target2 = target + (target * 0.05).toInt();

  int s = 0;
  for (int x in partial) s += x;
  if (s >= target1 && s <= target2) {
    // print("sum(" + partial.toString() + ")=" + target.toString());
    count++;
  }
  if (s >= target) return;
  for (int i = 0; i < numbers.length; i++) {
    List<int> remaining = [];
    int n = numbers[i];
    for (int j = i + 1; j < numbers.length; j++) remaining.add(numbers[j]);
    List<int> partial_rec = [...partial];
    partial_rec.add(n);
    sum_up_recursive(remaining, target, partial_rec);
  }
}

void sum_up(List<int> numbers, int target) {
  sum_up_recursive(numbers, target, []);
}

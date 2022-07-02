import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/primaryButton.dart';
import '../Widgets/secondaryButton.dart';
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
    required this.onImage,
  }) : super(key: key);

  final String title;
  final Widget? overlay;
  final InputCameraMode mode;
  final InputCameraType cameraDefault;
  final ResolutionPreset resolutionPreset;
  final bool canSwitchMode;
  final String? action;
  final void Function()? onTapAction;
  final Function(InputImage inputImage) onImage;

  @override
  _InputCameraViewState createState() => _InputCameraViewState();
}

class _InputCameraViewState extends State<InputCameraView> {
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

  // Future<void> _restartLiveStream() async {
  //   await _stopLiveStream();
  //   await _startLiveStream();
  // }

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

  // Future<void> _switchMode() async {
  //   if (_isLive) {
  //     _mode = InputCameraMode.gallery;
  //     await _stopLiveStream();
  //   } else {
  //     _mode = InputCameraMode.live;
  //     await _startLiveStream();
  //   }

  //   _refresh();
  // }

  // Future<void> _switchCamera() async {
  //   _cameraIndex = _cameraIndex == 0 ? 1 : 0;
  //   await _restartLiveStream();
  // }

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

      widget.onImage(InputImage.fromFile(image,
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

    widget.onImage(inputImage);
  }

  // Widget get _live {
  //   if (_controller != null && _controller!.value.isInitialized) {
  //     return Container(
  //       color: Colors.black,
  //       child: Stack(
  //         fit: StackFit.expand,
  //         children: [
  //           CameraPreview(_controller!),
  //           widget.overlay ?? Container(),
  //         ],
  //       ),
  //     );
  //   }

  //   return Container();
  // }

  // Widget get _gallery {
  //   return SingleChildScrollView(
  //     child: Column(
  //       // crossAxisAlignment: CrossAxisAlignment.,
  //       children: [
  //         SizedBox(height: 24),
  //         _image == null ? _imageSvg : _imagePreview,
  //         SizedBox(height: 28),
  //         // if (_showAction) ...[
  //         //   Center(
  //         //     child: NormalPinkButton(
  //         //       text: widget.action,
  //         //       onPressed: widget.onTapAction,
  //         //     ),
  //         //   ),
  //         //   SizedBox(height: 8),
  //         // ],
  //         Center(
  //           child: NormalButton(
  //             text: 'Choose Image',
  //             textColor: Colors.black,
  //             background: Colors.lime,
  //             fontSize: 18,
  //             onPressed: _chooseImage,
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Center(
  //           child: NormalButton(
  //             textColor: Colors.black,
  //             background: Colors.lime,
  //             text: 'Take Photo',
  //             fontSize: 18,
  //             onPressed: _takePhoto,
  //           ),

  //           //  NormalBlueButton(
  //           //   text: 'take anything',
  //           //   onPressed: _takePhoto,
  //           // ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

  // Widget get _fab {
  //   if (_mode == InputCameraMode.gallery) return Container();
  //   if (cameras.length == 1) return Container();

  //   return Container(
  //     height: 72,
  //     width: 72,
  //     child: FloatingActionButton(
  //       child: _flipSvg,
  //       onPressed: _switchCamera,
  //     ),
  //   );
  // }

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
                          CupertinoIcons.add,
                          color: colorWhite,
                        ),
                        name: "Category",
                        onPressed: _takePhoto),
                    SecondaryButton(
                        icon: const Icon(
                          CupertinoIcons.add,
                          color: colorWhite,
                        ),
                        name: "Total",
                        onPressed: _chooseImage)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 180,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                        // Initial Value
                        value: _dropDownValue,
                        underline: Container(
                          height: 2,
                          color: Color.fromRGBO(106, 166, 174, 1),
                        ),
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
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
                    Container(width: 180, child: TextField()),
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
          onPressed: () => {}),
    );
  }
}

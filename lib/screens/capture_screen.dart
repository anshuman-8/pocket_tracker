import 'package:flutter/material.dart';
// import 'package:gect_hackathon/Widgets/secondaryButton.dart';
// import 'package:gect_hackathon/utilis/utilWidgets.dart';
// import '../learningInputImage/input_camera.dart';
import 'package:provider/provider.dart';
import '../learnTextRecognition/learn_text_recognition.dart';
import '../learningInputImage/learn_input_image.dart';
// import 'package:image_picker/image_picker.dart';

class CaptureScreen extends StatefulWidget {
  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  // const afterCapture({Key? key}) : super(key: key);
  TextRecognition? _textRecognition = TextRecognition();

  Future<void> _startRecognition(InputImage image) async {
    TextRecognitionState state =
        Provider.of<TextRecognitionState>(context, listen: false);

    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = image;
      state.data = await _textRecognition?.process(image);
      print(state.data);
      state.stopProcessing();
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      title: "Capture",
      onImage: _startRecognition,
      // image: widget.image,
      overlay: Consumer<TextRecognitionState>(
        builder: (_, state, __) {
          if (state.isNotEmpty) {
            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Text(
                  state.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

class TextRecognitionState extends ChangeNotifier {
  InputImage? _image;
  RecognizedText? _data;
  bool _isProcessing = false;

  InputImage? get image => _image;
  RecognizedText? get data => _data;
  String get text => _data!.text;
  bool get isNotProcessing => !_isProcessing;
  bool get isNotEmpty => _data != null && text.isNotEmpty;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set data(RecognizedText? data) {
    _data = data;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
// import 'package:gect_hackathon/Widgets/secondaryButton.dart';
// import 'package:gect_hackathon/utilis/utilWidgets.dart';
// import '../learningInputImage/input_camera.dart';
import 'package:provider/provider.dart';
import '../learnTextRecognition/learn_text_recognition.dart';
import '../learningInputImage/learn_input_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({Key? key}) : super(key: key);

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  // const afterCapture({Key? key}) : super(key: key);

  // Future<void> _startRecognition(InputImage image) async {
  //   TextRecognitionState state =
  //       Provider.of<TextRecognitionState>(context, listen: false);

  //   if (state.isNotProcessing) {
  //     state.startProcessing();
  //     state.image = image;
  //     state.data = await _textRecognition?.process(image);
  //     print("##############" + state.data!.text);
  //     FindTotal.findTotal(state.data!.text);
  //     state.stopProcessing();
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void _onSave(int total, String category) {
    print(total);
    print(category);
    FirebaseFirestore.instance
        .collection('users')
        .doc('user1')
        .collection('bills')
        .add({
      'amount': total,
      'category': category,
      'timestamp': Timestamp.now(),
      'imgName': ""
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      title: "Capture",
      onSave: _onSave,
      // image: widget.image,
      overlay: Consumer<TextRecognitionState>(
        builder: (_, state, __) {
          if (state.isNotEmpty) {
            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.95,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Text(
                  state.text,
                  style: const TextStyle(
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

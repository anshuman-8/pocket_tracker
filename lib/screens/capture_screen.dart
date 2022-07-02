import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../learnTextRecognition/learn_text_recognition.dart';
import '../learningInputImage/learn_input_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({Key? key}) : super(key: key);

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  User? user;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  void _onSave(int total, String category, File? imageFile) {
    String filename = Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref();
    final imgRef = storageRef.child("media/users/${user?.uid}/$filename");
    try {
      print("---------------------");
      print(imageFile.toString());
      String imgExt = imageFile!.path.substring(
          imageFile.path.lastIndexOf('.') + 1, imageFile.path.length);
      print("Here");
      _uploadImage(imgRef, imageFile, imgExt);
    } catch (e) {
      print(e);
    }

    print(total);
    print(category);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('bills')
        .add({
      'amount': total,
      'category': category,
      'timestamp': Timestamp.now(),
      'imgName': imageFile == null ? "" : filename
    });
    Navigator.of(context).pop();
  }

  void _uploadImage(Reference imgRef, File imageFile, String imgExt) async {
    imgRef.putFile(imageFile, SettableMetadata(contentType: 'image/$imgExt'));
    print("File Uploaded");
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
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0.8),
                //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
                // ),
                // child: Text(
                //   state.text,
                //   style: const TextStyle(
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
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

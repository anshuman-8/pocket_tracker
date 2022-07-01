import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/secondaryButton.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';

class afterCapture extends StatelessWidget {
  const afterCapture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 1),
          child: Container(height: MediaQuery.of(context).size.height * 0.67),
        )),
        addHorizontalSpace(32),
        SecondaryButton()
      ],
    ));
  }
}

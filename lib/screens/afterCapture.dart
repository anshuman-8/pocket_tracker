import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/primaryButton.dart';
import 'package:gect_hackathon/Widgets/secondaryButton.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';

class AfterCapture extends StatelessWidget {
  const AfterCapture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 1),
              child:
                  Container(height: MediaQuery.of(context).size.height * 0.73),
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
                        onPressed: () => {}),
                    SecondaryButton(
                        icon: const Icon(
                          CupertinoIcons.add,
                          color: colorWhite,
                        ),
                        name: "Total",
                        onPressed: () => {})
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: 180, child: TextField()),
                    Container(width: 180, child: TextField()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: PrimaryButton(
          name: "CAPTURE YOUR BILL",
          icon: const Icon(
            CupertinoIcons.down_arrow,
            size: 24,
          ),
          onPressed: () => {}),
    );
  }
}

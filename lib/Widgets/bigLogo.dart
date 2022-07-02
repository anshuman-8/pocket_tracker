import 'package:flutter/material.dart';

import '../utilis/theme.dart';
import '../utilis/utilWidgets.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      alignment: Alignment.center,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: colorWhite),
      child: Column(
        children: [
          addVerticalSpace(10),
          const SizedBox(
            height: 80,
            width: 60,
            child: Image(image: AssetImage("assets/images/Vector.png")),
          ),
          const Text(
            "POCKET TRACKER",
            style: TextStyle(
                fontFamily: 'Abel',
                fontSize: 14,
                letterSpacing: 1.5,
                color: colorBlack),
          ),
          const Text(
            "You spend We'll take care",
            style: TextStyle(
                letterSpacing: 0.5,
                fontFamily: 'lato',
                fontSize: 11,
                color: colorBlack),
          ),
        ],
      ),
    );
  }
}

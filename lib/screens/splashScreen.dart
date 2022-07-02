import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/bigLogo.dart';
import 'package:gect_hackathon/Widgets/primaryButton.dart';
import 'package:gect_hackathon/Widgets/secondaryButton.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [colorPrimary, Color(0xeaadecca)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        children: [
          addVerticalSpace(180),
          const Logo(),
          addVerticalSpace(64),
          PrimaryButton(
              name: "JUST ONE TAP AWAY",
              icon: Icon(CupertinoIcons.arrow_right),
              onPressed: () => {}),
          Text(
            "IT'S THAT EASY",
            style: textThemeDefault.bodyText1,
          )
        ],
      ),
    ));
  }
}

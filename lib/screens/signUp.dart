import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/customInput.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';

import '../Widgets/bigLogo.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorPrimary, colorSecondary]),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(42),
            const Logo(),
            addVerticalSpace(42),
            CustomInput(
              hint: "ENTER YOUR NAME",
              icon: CupertinoIcons.text_alignright,
              controller: name,
            ),
            CustomInput(
              hint: "ENTER YOUR EMAIL",
              icon: CupertinoIcons.mail,
              controller: email,
            ),
            CustomInput(
              hint: "ENTER YOUR PASSWORD",
              icon: CupertinoIcons.padlock,
              controller: password,
            ),
            CustomInput(
              hint: "CONFIRM YOUR PASSWORD",
              icon: CupertinoIcons.padlock_solid,
              controller: confirmPassword,
            ),
            addVerticalSpace(64),
            TextButton(
                onPressed: () => {},
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    "SIGN UP",
                    style: textThemeDefault.bodyText1,
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}

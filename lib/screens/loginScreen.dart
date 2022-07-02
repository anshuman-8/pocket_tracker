// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/bigLogo.dart';
import 'package:gect_hackathon/Widgets/customInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';
import 'signUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _signin() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await Navigator.of(context).pushNamed('/home-screen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e);
      }
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(72),
            const Logo(),
            addVerticalSpace(72),
            CustomInput(
              hint: "ENTER YOUR EMAIL",
              icon: CupertinoIcons.mail,
              controller: _emailController,
            ),
            // CustomInput(
            //   hint: "ENTER YOUR PASSWORD",
            //   icon: CupertinoIcons.padlock,
            //   controller: _passwordController,
            // ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      obscureText: true,
                      style: textThemeDefault.bodyText2,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                          ),
                          suffixIcon: Icon(
                            CupertinoIcons.padlock,
                            color: colorPrimary,
                          ),
                          border: const OutlineInputBorder(),
                          hintText: "ENTER YOUR PASSWORD",
                          hintStyle: textThemeDefault.bodyText2,
                          fillColor: colorDark,
                          filled: true),
                      controller: _passwordController,
                    ),
                  ),
                ]),
            addVerticalSpace(88),
            TextButton(
                onPressed: _signin,
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
                    "LOGIN",
                    style: textThemeDefault.bodyText1,
                  ),
                )),
            TextButton(
                onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignupScreen();
                    })),
                child: Text(
                  "NEW USER ? SIGN IN",
                  style: textThemeDefault.button,
                ))
          ],
        ),
      ),
    ));
  }
}

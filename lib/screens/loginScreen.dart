import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/customInput.dart';
import 'package:gect_hackathon/Widgets/primaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gect_hackathon/main.dart';
import 'package:provider/provider.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';
import 'signUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       // isSignedIn = false;
  //       print("Not signed in");
  //       Navigator.of(context).popAndPushNamed('/login');
  //     } else {
  //       print('User is signed in!');
  //       // isSignedIn = true;
  //       Navigator.of(context).popAndPushNamed('/home-screen');
  //     }
  //   });
  // }

  void _signin() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorPrimary, colorSecondary]),
      ),
      child: Column(
        children: [
          addVerticalSpace(300),
          CustomInput(
            hint: "ENTER YOUR EMAIL",
            icon: CupertinoIcons.mail,
            controller: _emailController,
          ),
          CustomInput(
            hint: "ENTER YOUR PASSWORD",
            icon: CupertinoIcons.padlock,
            controller: _passwordController,
          ),
          addVerticalSpace(132),
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
              child: Text("Sign Up"))
        ],
      ),
    ));
  }
}

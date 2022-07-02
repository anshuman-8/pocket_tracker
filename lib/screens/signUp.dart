import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/customInput.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/bigLogo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
      final user = userCredential.user;
      await user?.updateDisplayName(_nameController.text);
      Navigator.pushReplacementNamed(context, '/home-screen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(72),
            const Logo(),
            addVerticalSpace(42),
            CustomInput(
              hint: "ENTER YOUR NAME",
              icon: CupertinoIcons.text_alignright,
              controller: _nameController,
            ),
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
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      style: textThemeDefault.bodyText2,
                      obscureText: true,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                          ),
                          suffixIcon: Icon(
                            CupertinoIcons.padlock_solid,
                            color: colorPrimary,
                          ),
                          border: const OutlineInputBorder(),
                          hintText: "CONFIRM YOUR PASSWORD",
                          hintStyle: textThemeDefault.bodyText2,
                          fillColor: colorDark,
                          filled: true),
                      controller: _confirmPasswordController,
                    ),
                  ),
                ]),
            // CustomInput(
            //   hint: "CONFIRM YOUR PASSWORD",
            //   icon: CupertinoIcons.padlock_solid,
            //   controller: _confirmPasswordController,
            // ),
            addVerticalSpace(42),
            TextButton(
                onPressed: _signUp,
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

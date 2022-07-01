import 'package:flutter/material.dart';
import 'package:gect_hackathon/screens/afterCapture.dart';
import 'package:gect_hackathon/screens/homeScreen.dart';
import 'package:gect_hackathon/utilis/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: colorPrimary,
            primaryColorLight: colorPrimary20,
            primaryColorDark: colorDark,
            textTheme: textThemeDefault),
        title: 'Flutter Demo',
        home: const SafeArea(child: afterCapture()));
  }
}

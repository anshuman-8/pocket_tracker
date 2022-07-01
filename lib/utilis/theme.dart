import 'package:flutter/material.dart';

const colorPrimary = Color.fromRGBO(232, 241, 77, 1);
const colorSecondary = Color.fromRGBO(106, 166, 174, 1);
const colorPrimary20 = Color.fromRGBO(218, 227, 138, 1);
const colorDark = Color.fromRGBO(13, 65, 74, 1);
const colorBlack = Color.fromARGB(255, 43, 42, 42);
const colorGrey = Color.fromARGB(255, 208, 203, 203);
const colorWhite = Colors.white;

const TextTheme textThemeDefault = TextTheme(
  headline2: TextStyle(
      color: colorBlack,
      fontSize: 22,
      fontFamily: 'lato',
      fontWeight: FontWeight.w600),
  bodyText1: TextStyle(
    color: colorBlack,
    fontSize: 18,
    fontFamily: 'lato',
    fontWeight: FontWeight.w300,
  ),
  bodyText2: TextStyle(
      color: colorWhite, fontFamily: 'Abel', fontSize: 18, letterSpacing: 3.7),
  labelMedium: TextStyle(
      color: colorBlack, fontFamily: 'Abel', fontSize: 14, letterSpacing: 2.5),
  button: TextStyle(
    color: colorBlack,
    fontFamily: 'Abel',
    fontSize: 11,
  ),
);

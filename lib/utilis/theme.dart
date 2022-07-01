import 'package:flutter/material.dart';

const colorPrimary = Color.fromARGB(255, 73, 38, 213);
const colorSecondary = Color.fromARGB(255, 0, 141, 160);
const colorPrimary20 = Color.fromARGB(255, 227, 138, 169);
const colorDark = Color.fromRGBO(13, 65, 74, 1.0);
const colorBlack = Color.fromRGBO(48, 47, 48, 1.0);
const colorGrey = Color.fromRGBO(141, 141, 141, 1.0);
const colorWhite = Colors.white;

const TextTheme textThemeDefault = TextTheme(
    headline2: TextStyle(
        color: colorBlack,
        fontSize: 22,
        fontFamily: 'lato',
        fontWeight: FontWeight.w600),
    bodyText1: TextStyle(
      color: colorGrey,
      fontSize: 18,
      fontFamily: 'lato',
      fontWeight: FontWeight.w300,
    ),
    bodyText2: TextStyle(
        color: colorBlack,
        fontFamily: 'Abel',
        fontSize: 18,
        letterSpacing: 3.7),
    labelMedium: TextStyle(
        color: colorBlack,
        fontFamily: 'Abel',
        fontSize: 14,
        letterSpacing: 0.5),
    button: TextStyle(
      color: colorBlack,
      fontFamily: 'Abel',
      fontSize: 11,
    ));

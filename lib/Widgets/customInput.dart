// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/utilis/theme.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  const CustomInput(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              style: textThemeDefault.bodyText2,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                  suffixIcon: Icon(
                    icon,
                    color: colorPrimary,
                  ),
                  border: const OutlineInputBorder(),
                  hintText: hint,
                  hintStyle: textThemeDefault.bodyText2,
                  fillColor: colorDark,
                  filled: true),
              controller: controller,
            ),
          ),
        ]);
  }
}

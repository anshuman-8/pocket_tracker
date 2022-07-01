import 'package:flutter/material.dart';
import 'package:gect_hackathon/utilis/theme.dart';

class InfoButton extends StatelessWidget {
  final String text;

  const InfoButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      height: 32,
      margin: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          color: colorGrey),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        text,
        style: themeData.textTheme.button,
      ),
    );
  }
}

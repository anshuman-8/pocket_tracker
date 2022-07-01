// ignore: file_names
import 'package:flutter/material.dart';
import 'package:gect_hackathon/utilis/theme.dart';

class SecondaryButton extends StatelessWidget {
  final String name;
  final Icon icon;
  final void Function() onPressed;

  const SecondaryButton(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xFFE8F14D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          height: 40,
          width: 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                      color: colorDark,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: icon,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 1),
                  child: Text(
                    name,
                    style: textThemeDefault.labelMedium,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

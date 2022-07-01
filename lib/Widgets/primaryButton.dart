// ignore: file_names
import 'package:flutter/material.dart';
import 'package:gect_hackathon/utilis/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String name;
  final Icon icon;
  final void Function() onPressed;

  const PrimaryButton(
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
                color: colorDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            height: 40,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 1),
              // ----------------- CHILD OF BUTTON ---------------------------------------
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: textThemeDefault.bodyText2,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: colorDark,
                    textColor: colorPrimary,
                    shape: const CircleBorder(),
                    child: icon,
                  )
                ],
              ),
            )));
  }
}

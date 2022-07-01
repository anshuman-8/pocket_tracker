import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {},
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
          width: 130,
          child: Row(
            children: [Text("someIcn"), Text("TextIcon")],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {},
        child: Container(
          height: 40,
          width: 130,
          child: Row(
            children: [Text("someIcn"), Text("TextIcon")],
          ),
        ));
  }
}

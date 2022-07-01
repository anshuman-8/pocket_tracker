import 'package:flutter/material.dart';
import '../utilis/theme.dart';
import '../utilis/utilWidgets.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 1),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                addVerticalSpace(32),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Color(0xFFE8F14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(2000),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_balance_wallet_outlined),
                            Text(
                              "TOTAL EXPENDITURE",
                              style: textThemeDefault.labelMedium,
                            ),
                          ],
                        ),
                        Text(
                          "RS 250000",
                          style: textThemeDefault.labelMedium,
                        )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [Text("Row"), Text("Row")],
                  ),
                )
              ],
            )));
  }
}

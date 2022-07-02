import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/screens/homeScreen.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';

import '../Widgets/primaryButton.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  get boxDesign => const BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(28),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 220,
              width: MediaQuery.of(context).size.width * 0.97,
              decoration: boxDesign,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Aashraya Katiyar",
                              style: textThemeDefault.headline2),
                          Text("aashray446@gmail.com",
                              style: textThemeDefault.button)
                        ],
                      ),
                      IconButton(
                          onPressed: () => {},
                          tooltip: "Log Out",
                          icon: Icon(CupertinoIcons.arrow_turn_up_left))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.money_dollar,
                        size: 60,
                        color: colorDark,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          addVerticalSpace(80),
                          Text(
                            "Total Budget - RS 90000",
                            style: textThemeDefault.button,
                          ),
                          addVerticalSpace(4),
                          Text(
                            "Total Expendtiure - RS 90000",
                            style: textThemeDefault.button,
                          ),
                          addVerticalSpace(4),
                          Text("Net Amount - RS 90000",
                              style: textThemeDefault.bodyText1),
                        ],
                      )
                    ],
                  )
                ]),
              ),
            ),
            addVerticalSpace(48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Recent Transactions",
                style: textThemeDefault.bodyText1,
              ),
            ),
            addHorizontalSpace(18),
            RecentTransaction(
                date: "21/08/2022", color: colorPrimary, amount: "5000"),
            RecentTransaction(
                date: "21/08/2022", color: colorPrimary, amount: "5000"),
            RecentTransaction(
                date: "21/08/2022", color: colorPrimary, amount: "5000")
          ],
        ),
        bottomSheet: PrimaryButton(
          name: "GO TO DASHBOARD",
          icon: const Icon(CupertinoIcons.camera, color: colorWhite),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // Consumer<TextRecognitionState>(
                        //   builder: (context, value, child) =>
                        // CaptureScreen(),
                        HomeScreen()))
            // CaptureScreen(_image!);
          },
        ),
      ),
    );
  }
}

class RecentTransaction extends StatelessWidget {
  final String date;
  final Color color;
  final String amount;

  const RecentTransaction(
      {Key? key, required this.date, required this.color, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(border: Border.all(color: colorDark)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: textThemeDefault.button),
          Container(
            margin: const EdgeInsets.only(right: 8),
            width: 16,
            height: 16,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          Text(
            amount,
            style: textThemeDefault.button,
          )
        ],
      ),
    );
  }
}

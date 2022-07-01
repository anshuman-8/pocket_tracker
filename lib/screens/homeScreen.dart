import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/category.dart';
import 'package:gect_hackathon/Widgets/infoButton.dart';
import 'package:gect_hackathon/Widgets/primaryButton.dart';
import 'package:gect_hackathon/Widgets/secondaryButton.dart';
import '../utilis/theme.dart';
import '../utilis/utilWidgets.dart';
import 'capture_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: const BoxDecoration(
                  color: colorPrimary,
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
          ),
          addVerticalSpace(12),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  InfoButton(text: "Week"),
                  InfoButton(text: "Month"),
                  InfoButton(text: "Year")
                ],
              )),
          addVerticalSpace(48),
          Container(
            height: 260,
          ),
          addVerticalSpace(48),
          Container(
            height: 152,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: const [
                  CategoryList(
                      amount: "5000", category: "FOOD", color: colorPrimary),
                  CategoryList(
                      amount: "2000", category: "CLOTH", color: colorPrimary20),
                  CategoryList(
                      amount: "1000", category: "FOOD", color: colorBlack),
                  CategoryList(
                      amount: "7000",
                      category: "INTERNET",
                      color: colorSecondary),
                  CategoryList(
                      amount: "7000",
                      category: "INTERNET",
                      color: colorSecondary),
                  CategoryList(
                      amount: "7000",
                      category: "INTERNET",
                      color: colorSecondary),
                ],
              ),
            ),
          ),
          addVerticalSpace(72),
          SecondaryButton(
              name: "Expenditure",
              icon: const Icon(
                CupertinoIcons.add,
                color: colorWhite,
              ),
              onPressed: () => {})
        ],
      ),
      bottomSheet: PrimaryButton(
        name: "CAPUTRE YOUR BILL",
        icon: const Icon(CupertinoIcons.camera, color: colorWhite),
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // Consumer<TextRecognitionState>(
                    //   builder: (context, value, child) =>
                    CaptureScreen(),
              ))
          // CaptureScreen(_image!);
        },
      ),
    );
  }
}

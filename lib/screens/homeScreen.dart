import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/category.dart';
import 'package:gect_hackathon/Widgets/infoButton.dart';
import 'package:gect_hackathon/Widgets/primaryButton.dart';
import 'package:gect_hackathon/Widgets/secondaryButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utilis/theme.dart';
import '../utilis/utilWidgets.dart';
import '../models/models.dart';
import 'capture_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Bill> _bills = [];

  String _getTotalExpenditure() {
    int total = 0;
    _bills.forEach((bill) {
      total = total + bill.amount;
    });
    return total.toString();
  }

  Widget _billSummaryBuilder() {
    Map<String, int> categories = {};
    Map<String, Color> categoryColors = {
      'food': colorPrimary,
      'grocery': colorSecondary,
      'medical': colorWhite,
      'fuel': colorBlack
    };
    _bills.forEach((bill) {
      if (categories.containsKey(bill.category)) {
        categories[bill.category] = categories[bill.category]! + bill.amount;
      } else {
        categories[bill.category] = bill.amount;
      }
    });

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          String key = categories.keys.elementAt(index);
          return CategoryList(
              amount: categories[key].toString(),
              category: '${key[0].toUpperCase()}${key.substring(1)}',
              color: (categoryColors.keys.contains(key)
                  ? categoryColors[key]
                  : colorPrimary)!);
        }),
        itemCount: categories.length);
  }

  @override
  void initState() {
    super.initState();
  }

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
                      "RS " + _getTotalExpenditure(),
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              height: 152,
              child: Column(
                // children: const [
                //   CategoryList(
                //       amount: "5000", category: "FOOD", color: colorPrimary),
                //   CategoryList(
                //       amount: "2000", category: "CLOTH", color: colorPrimary20),
                //   CategoryList(
                //       amount: "1000", category: "FOOD", color: colorBlack),
                //   CategoryList(
                //       amount: "7000",
                //       category: "INTERNET",
                //       color: colorSecondary),
                //   CategoryList(
                //       amount: "7000",
                //       category: "INTERNET",
                //       color: colorSecondary),
                //   CategoryList(
                //       amount: "7000",
                //       category: "INTERNET",
                //       color: colorSecondary),
                // ],
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc('user1')
                          .collection('bills')
                          .snapshots(),
                      builder: (context, snapshot) {
                        print('Here');
                        if (snapshot.hasData) {
                          print('Has Data');
                          _bills = [];
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot document = snapshot.data!.docs[i];
                            _bills.add(Bill(
                                amount: document['amount'],
                                category: document['category'],
                                timestamp: document['timestamp'],
                                imgName: document['imgName']));
                            print(snapshot.data!.docs[i].data());
                          }
                          return _billSummaryBuilder();
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })
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

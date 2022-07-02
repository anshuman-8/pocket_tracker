import 'package:firebase_auth/firebase_auth.dart';
import 'package:gect_hackathon/Widgets/donut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/Widgets/category.dart';
import 'package:gect_hackathon/Widgets/infoButton.dart';
import 'package:gect_hackathon/Widgets/primaryButton.dart';
import 'package:gect_hackathon/Widgets/secondaryButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gect_hackathon/screens/myProfile.dart';
import '../Widgets/donut.dart';
import '../utilis/theme.dart';
import '../utilis/utilWidgets.dart';
import '../models/models.dart';
import 'capture_screen.dart';
// import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Bill> _bills = [];
  Map<String, int> categoryAmounts = {};
  Map<String, Color> categoryColors = {
    'food': colorPrimary,
    'grocery': colorSecondary,
    'medical': Colors.green,
    'fuel': colorBlack
  };
  int totalExpenditure = 0;
  late final User? user;

  String _getTotalExpenditure() {
    totalExpenditure = 0;
    _bills.forEach((bill) {
      totalExpenditure = totalExpenditure + bill.amount;
    });
    return totalExpenditure.toString();
  }

  Widget _billSummaryBuilder() {
    categoryAmounts.clear();
    _bills.forEach((bill) {
      if (categoryAmounts.containsKey(bill.category)) {
        categoryAmounts[bill.category] =
            categoryAmounts[bill.category]! + bill.amount;
      } else {
        categoryAmounts[bill.category] = bill.amount;
      }
    });

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        margin: EdgeInsets.fromLTRB(0, 110, 0, 0),
        height: 50,
        child: DonutChart(categoryAmounts, categoryColors),
      ),
      Container(
        height: 130,
      ),
      addVerticalSpace(48),
      Container(
          height: 152,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      String key = categoryAmounts.keys.elementAt(index);
                      return CategoryList(
                          amount: categoryAmounts[key].toString(),
                          category:
                              '${key[0].toUpperCase()}${key.substring(1)}',
                          color: (categoryColors.keys.contains(key)
                              ? categoryColors[key]
                              : colorPrimary)!);
                    }),
                    itemCount: categoryAmounts.length)
              ])))
    ]);
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user?.displayName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(32),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection('bills')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _bills = [];
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    DocumentSnapshot document = snapshot.data!.docs[i];
                    _bills.add(Bill(
                        amount: document['amount'],
                        category: document['category'],
                        timestamp: document['timestamp'],
                        imgName: document['imgName']));
                    // print(snapshot.data!.docs[i].data());
                  }
                  return _billSummaryBuilder();
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          addVerticalSpace(38),
          SecondaryButton(
              name: "Your Profile",
              icon: const Icon(
                CupertinoIcons.person_alt,
                color: colorWhite,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).popAndPushNamed('/myProfile');
              })
        ],
      ),
      bottomSheet: PrimaryButton(
        name: "CAPTURE YOUR BILL",
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

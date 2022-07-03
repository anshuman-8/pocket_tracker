import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/screens/homeScreen.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:gect_hackathon/utilis/utilWidgets.dart';

import '../Widgets/primaryButton.dart';
import 'homeScreen.dart';
import '../models/models.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.bills}) : super(key: key);

  final List<Bill> bills;
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<RecentTransaction> _recentTransactions = [];
  late final User? user;

  Map<String, Color> categoryColors = {
    'food': colorPrimary,
    'grocery': colorSecondary,
    'medical': Colors.green,
    'fuel': colorBlack,
    'others': Colors.amberAccent
  };

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user?.displayName);
  }

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

  int _getTotalExpenditure() {
    int totalExpenditure = 0;
    widget.bills.forEach((bill) {
      totalExpenditure = totalExpenditure + bill.amount;
    });
    return totalExpenditure;
  }

  Widget _buildRecentTransactions() {
    _recentTransactions.clear();
    widget.bills.sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
    for (Bill bill in widget.bills) {
      print('TTTTTTTTTT');
      DateTime dt = bill.timestamp.toDate();
      _recentTransactions.add(RecentTransaction(
        amount: bill.amount.toString(),
        color: categoryColors[bill.category]!,
        date: '${dt.day}/${dt.month}/${dt.year}',
        imgUrl: bill.imgName,
      ));
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return _recentTransactions[index];
        }),
        itemCount: _recentTransactions.length);
  }

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
                          Text(user?.displayName ?? 'No Name',
                              style: textThemeDefault.headline2),
                          Text(user?.email ?? 'No Email',
                              style: textThemeDefault.button)
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pop();
                          },
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
                          addVerticalSpace(100),
                          Text(
                            "Total Expendtiure",
                            style: textThemeDefault.button,
                          ),
                          addVerticalSpace(4),
                          Text("Rs " + _getTotalExpenditure().toString(),
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
            Expanded(
                child: SingleChildScrollView(
              child: _buildRecentTransactions(),
            )),
          ],
        ),
        bottomSheet: PrimaryButton(
          name: "GO TO DASHBOARD",
          icon: const Icon(CupertinoIcons.doc, color: colorWhite),
          onPressed: () => {
            Navigator.pop(context)
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
  final String imgUrl;

  const RecentTransaction(
      {Key? key,
      required this.date,
      required this.color,
      required this.amount,
      required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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

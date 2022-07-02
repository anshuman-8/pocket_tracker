import 'package:flutter/material.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({Key? key}) : super(key: key);

  get boxDesign => const BoxDecoration(
        color: Colors.teal,
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
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 220,
              width: MediaQuery.of(context).size.width * 0.97,
              decoration: boxDesign,
            ),
          ),
          const SizedBox(
            height: 23,
          ),
          const Text("Recent Transactions"),
        ],
      ),
    );
  }
}

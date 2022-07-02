import 'package:cloud_firestore/cloud_firestore.dart';

class Bill {
  final int amount;
  final String category;
  final Timestamp timestamp;
  final String imgName;

  Bill(
      {required this.amount,
      required this.category,
      required this.timestamp,
      required this.imgName});
  // static fromJson(Map<String, dynamic> json) {
  //   return Bill(json['amount'], json['category'], json['timestamp'], json['imgName']);
  // }
}

import 'package:flutter/material.dart';
import 'package:gect_hackathon/utilis/theme.dart';

class CategoryList extends StatelessWidget {
  final String amount;
  final String category;
  final Color color;
  const CategoryList(
      {Key? key,
      required this.amount,
      required this.category,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
              Text(
                category,
                style: textThemeDefault.bodyText1,
              )
            ],
          ),
          Text(
            "Rs $amount",
            style: textThemeDefault.bodyText1,
          )
        ],
      ),
    );
  }
}

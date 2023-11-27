import 'package:flutter/material.dart';

class CategoryWiseSumContainer extends StatelessWidget {
  final String title;
  final String amount;
  const CategoryWiseSumContainer({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.8, color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                // color: GlobalVariables.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Text(
            "₹ $amount",
            style: const TextStyle(
                // color: GlobalVariables.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ],
      ),
    );
  }
}

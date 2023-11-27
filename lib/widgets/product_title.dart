import 'package:flutter/material.dart';

class productTitleWidget extends StatelessWidget {
  final String label;
  const productTitleWidget({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // TextButton(onPressed: () {}, child: Text("View All")),
        ],
      ),
    );
  }
}

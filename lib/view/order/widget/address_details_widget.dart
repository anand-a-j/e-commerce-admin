import 'package:e_commerce_admin/models/orders.dart';
import 'package:flutter/material.dart';

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.7, color: Colors.grey)),
        child: Text(
          order.address,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

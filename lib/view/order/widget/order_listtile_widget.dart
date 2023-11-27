import 'package:e_commerce_admin/models/orders.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class OrderLIstTileWidget extends StatelessWidget {
  final Order order;
  const OrderLIstTileWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.8, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Order ID:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                order.id,
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Items:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                order.products.length.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Price:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                order.totalPrice.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Date:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                dateConvert(order.orderedAt),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Status:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              orderStatus(order.status)
            ],
          ),
        ],
      ),
    );
  }

  Widget orderStatus(int status) {
    switch (status) {
      case 1:
        return Chip(
          backgroundColor: Colors.blue.shade200,
          label: const Text(
            "Packed",
          ),
        );
      case 2:
        return Chip(
          backgroundColor: Colors.purple.shade200,
          label: const Text(
            "Shipping",
          ),
        );
      case 3:
        return Chip(
          backgroundColor: Colors.green.shade200,
          label: const Text(
            "Delivered",
          ),
        );
      default:
        return Chip(
          backgroundColor: Colors.orange.shade200,
          label: const Text("Pending"),
        );
    }
  }
}

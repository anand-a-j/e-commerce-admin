import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/models/orders.dart';
import 'package:e_commerce_admin/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({
    super.key,
    required this.order,
    required this.user,
  });

  final Order order;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, admin, _) {
      return Stepper(
        currentStep: order.status,
        controlsBuilder: (context, details) {
          if (user.type == 'admin') {
            return ElevatedButton(
                onPressed: () => admin.changeOrderStatus(context, order),
                child: const Text("Done"));
          }
          return const SizedBox.shrink();
        },
        steps: [
          Step(
              title: const Text('Pending'),
              content: const Text(
                'Your order is yet to be delivered',
              ),
              isActive: admin.currentStep >= 0),
          Step(
              title: const Text('Packed'),
              content: const Text(
                'Order packed and shipping soon!',
              ),
              isActive: admin.currentStep > 1),
          Step(
              title: const Text('Shipping'),
              content: const Text(
                'Your order stated shipping',
              ),
              isActive: admin.currentStep > 2),
          Step(
              title: const Text('Delivered'),
              content: const Text(
                'Your order has been delivered and signed by you!',
              ),
              isActive: admin.currentStep >= 3 && admin.currentStep <= 3),
        ],
      );
    });
  }
}

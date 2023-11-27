import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/models/orders.dart';
import 'package:e_commerce_admin/models/user.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/widgets/custom_textfield.dart';
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
    TextEditingController statusController = TextEditingController();
    return Consumer<AdminProvider>(builder: (context, admin, _) {
      GlobalVariables.orderStatusList;
      return Column(
        children: [
          user.type == 'admin'
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      CustomTextField(
                        controller: statusController,
                        hintText: "Change order status here",
                        isEnabled: true,
                      ),
                      Positioned(
                          right: 10,
                          child: DropdownButton<String>(
                            underline: const SizedBox.shrink(),
                            items: GlobalVariables.orderStatusList
                                .map((Map<String, dynamic> value) {
                              return DropdownMenuItem<String>(
                                value: value['value'].toString(),
                                child: Text(
                                  value['title'],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              admin.changeOrderStatus(
                                  context, order, int.parse(value!));
                              statusController.text = GlobalVariables.orderStatusList[int.parse(value)]['title'];
                            },
                          ))
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Stepper(
            currentStep: order.status,
            controlsBuilder: (context, details) {
              return const SizedBox.shrink();
            },
            steps: [
              Step(
                  title: const Text('Pending'),
                  content: const Text(
                    'Your order is yet to be delivered',
                  ),
                  isActive: admin.currentStep == 0 || admin.currentStep >= 0),
              Step(
                  title: const Text('Packed'),
                  content: const Text(
                    'Order packed and shipping soon!',
                  ),
                  isActive: admin.currentStep >= 1),
              Step(
                  title: const Text('Shipping'),
                  content: const Text(
                    'Your order stated shipping',
                  ),
                  isActive: admin.currentStep >= 2),
              Step(
                  title: const Text('Delivered'),
                  content: const SizedBox.shrink(),
                  isActive: admin.currentStep >= 3),
            ],
          ),
        ],
      );
    });
  }
}

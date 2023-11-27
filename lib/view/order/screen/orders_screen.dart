import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:e_commerce_admin/view/order/screen/order_details_screen.dart';
import 'package:e_commerce_admin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
   WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).fetchOrders(context);
    });
    return Consumer<AdminProvider>(
      builder: (context,admin,_) {
        return admin.isLoading
            ? const Loader()
            : admin.orders!.isEmpty
                ? const Text("No orders placed")
                : ListView.builder(
                    itemCount: admin.orders!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                              arguments: admin.orders![index]);
                        },
                        child: Container(
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
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    admin.orders![index].id,
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
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    admin.orders![index].products.length.toString(),
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
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '₹ ${admin.orders![index].totalPrice.toString()}',
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
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dateConvert(admin.orders![index].orderedAt),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const  Text(
                                  "Status:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                orderStatus(admin.orders![index].status)
                              ],
                            ), 
                            ],
                          ),
                        ),
                      );
                    },
                  );
      }
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

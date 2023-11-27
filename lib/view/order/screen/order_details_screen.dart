import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/controllers/user_provider.dart';
import 'package:e_commerce_admin/models/orders.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:e_commerce_admin/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).setOrderStatus(widget.order.status);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const productTitleWidget(label: "Order Details"),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text("Order Id"), Text(widget.order.id)],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Date"),
                    Text(dateConvert(widget.order.orderedAt))
                  ],
                ),
              ),
            ],
          ),
          const productTitleWidget(label: "Shipping Address"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.7, color: Colors.grey)),
              child: Text(
                widget.order.address,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const productTitleWidget(label: "Products"),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.order.products.length,
            itemBuilder: (context, index) {
              var product = widget.order.products[index];
              return SizedBox(
                height: 70,
                width: double.infinity,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(product.images[0]),
                          fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                      "Quantity: ${product.quantity} Price: ${product.price}"),
                ),
              );
            },
          ),
          const productTitleWidget(label: "Price Details"),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total"),
                    Text(widget.order.totalPrice.toString())
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Delivery Charge"), Text("Free")],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Tax"), Text("₹0.00")],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sub Total"),
                    Text('₹ ${widget.order.totalPrice}0')
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const productTitleWidget(label: "Order Status"),
          Consumer<AdminProvider>(builder: (context, admin, _) {
            return Stepper(
              currentStep: widget.order.status,
              controlsBuilder: (context, details) {
                if (user.type == 'admin') {
                  return ElevatedButton(
                      onPressed: () =>
                          admin.changeOrderStatus(context, widget.order),
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
          })
        ],
      ),
    );
  }
}

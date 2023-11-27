import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/controllers/user_provider.dart';
import 'package:e_commerce_admin/models/orders.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/view/order/widget/address_details_widget.dart';
import 'package:e_commerce_admin/view/order/widget/order_details_widget.dart';
import 'package:e_commerce_admin/view/order/widget/order_status_widget.dart';
import 'package:e_commerce_admin/view/order/widget/orderedproduct_deatails_widet.dart';
import 'package:e_commerce_admin/view/order/widget/price_details_widget.dart';
import 'package:e_commerce_admin/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
   
    final user = Provider.of<UserProvider>(context).user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false)
          .setOrderStatus(order.status);
    });

     List<Widget> widgets = [
      const productTitleWidget(label: "Order Details"),
      OrderDetailsWidget(order: order),
      const productTitleWidget(label: "Shipping Address"),
      AddressDetailsWidget(order: order),
      const productTitleWidget(label: "Products"),
      OrderedProductsWidget(order: order),
      const productTitleWidget(label: "Price Details"),
      PriceDetailsWidget(order: order),
      const SizedBox(height: 10),
      const productTitleWidget(label: "Order Status"),
      OrderStatusStepper(order: order, user: user)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context,index) => widgets[index],
        itemCount: widgets.length,
      ),
    );
  }
}








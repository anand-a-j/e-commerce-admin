import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/view/order/screen/order_details_screen.dart';
import 'package:e_commerce_admin/view/order/widget/order_listtile_widget.dart';
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
    return Consumer<AdminProvider>(builder: (context, admin, _) {
      return admin.isLoading
          ? const Loader()
          : admin.orders!.isEmpty
              ? const Text("No orders placed")
              : ListView.builder(
                  itemCount: admin.orders!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrderDetailsScreen.routeName,
                            arguments: admin.orders![index]);
                      },
                      child: OrderLIstTileWidget(order: admin.orders![index]),
                    );
                  },
                );
    });
  }
}

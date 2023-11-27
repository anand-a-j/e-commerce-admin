import 'package:e_commerce_admin/models/orders.dart';
import 'package:flutter/material.dart';

class OrderedProductsWidget extends StatelessWidget {
  const OrderedProductsWidget({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: order.products.length,
      itemBuilder: (context, index) {
        var product = order.products[index];
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
                    image: NetworkImage(product.images[0]), fit: BoxFit.cover),
              ),
            ),
            title: Text(product.name),
            subtitle:
                Text("Quantity: ${product.quantity} Price: ${product.price}"),
          ),
        );
      },
    );
  }
}


import 'package:e_commerce_admin/view/auth/screens/sign_in_screen.dart';
import 'package:e_commerce_admin/view/product/screen/posts_screen.dart';
import 'package:flutter/material.dart';
import 'models/orders.dart';
import 'view/product/screen/add_product_screen.dart';
import 'view/order/screen/order_details_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignInScreen());
    case PostsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PostsScreen());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Error!!!"),
          ),
        ),
      );
  }
}

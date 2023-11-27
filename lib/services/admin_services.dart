import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_admin/controllers/user_provider.dart';
import 'package:e_commerce_admin/models/orders.dart';
import 'package:e_commerce_admin/models/product.dart';
import 'package:e_commerce_admin/models/sales_model.dart';
import 'package:e_commerce_admin/utils/api.dart';
import 'package:e_commerce_admin/utils/error_handling.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:e_commerce_admin/view/auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  // sell products------------------------------------------------------------
  Future<bool> sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool isSaved;
    try {
      isSaved = false;
      // Uploading images to Cloundinary Storage
      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);

      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(response.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        price: price,
        images: imageUrls,
        category: category,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: product.toJson(),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              isSaved = true;
            });
      }
      return isSaved;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'add product post err ${e.toString()}');
      }
      isSaved = false;
      return isSaved;
    }
  }

  // fetch all products---------------------------------------------------------
  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    debugPrint("fetch product function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    debugPrint("token ${userProvider.user.token}");
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response => ${response.statusCode}");
      debugPrint("response => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                productList.add(
                  ProductModel.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
              debugPrint(
                  "response fetchAllProducts===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("get product error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return productList;
  }

  // fetch all orders-----------------------------------------------------------
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    debugPrint("fetch all orders function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response => ${response.statusCode}");
      debugPrint("response => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                orderList.add(
                  Order.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
            });
      }
    } catch (e) {
      debugPrint("get order error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return orderList;
  }

  // fetch all earning details-----------------------------------------------------------
  Future<Map<String, dynamic>> fetchEarnings(BuildContext context) async {
    debugPrint("fetch all analytics function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales>? sales = [];
    int totalEarning = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              var res = jsonDecode(response.body);
              totalEarning = res['totalEarnings'];
              sales = [
                Sales('SmartPhone', res['SmartPhoneEarnings']),
                Sales('Laptop', res['LaptopEarnings']),
                Sales('Tablet', res['TabletEarnings']),
                Sales('Speakers', res['SpeakersEarnings']),
                Sales('SmartWatch', res['SmartWatchEarnings']),
                Sales('HeadPhones', res['HeadPhonesEarnings'])
              ];
            });
      }
    } catch (e) {
      debugPrint("get order error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return {'sales': sales, 'totalEarnings': totalEarning};
  }

  // Delete a product-----------------------------------------------------------
  void deleteProduct(
      {required BuildContext context,
      required ProductModel product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonEncode({'id': product.id}),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              onSuccess();
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'add product post err ${e.toString()}');
      }
    }
  }

// change order status----------------------------------------------------------
  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonEncode({'id': order.id, 'status': status}),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              onSuccess();
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<List<Order>> fetchOrderDetails({required BuildContext context}) async {
    debugPrint("fetchorder function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/current-user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response category statuscode => ${response.statusCode}");
      debugPrint("response category body => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                orderList.add(
                  Order.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
              debugPrint(
                  "response catefgory===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("get product-category error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '');
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, SignInScreen.routeName, (route) => false);
        showSnackBar(context, "Logout Successfully", isError: false);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
  }
}

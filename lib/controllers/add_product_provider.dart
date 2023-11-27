import 'dart:io';
import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/services/admin_services.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductProvider extends ChangeNotifier {
   final AdminServices adminServices = AdminServices();

  final List<String> _productCategory = [
    'SmartPhone',
    'Laptop',
    'Tablet',
    'Speakers',
    'SmartWatch'
  ];

  bool _isLoading = false;
  List<File> _images = [];
  String? _category;
  bool _isSaved = false;

  bool get isLoading => _isLoading;
  List<File> get images => _images;
  String? get category => _category;
  List<String> get productCategory => _productCategory;
  bool get isSaved => _isSaved;

  void setSelectedCategory(String? value) {
    _category = value;
    notifyListeners();
  }

  void selectImages() async {
    try {
      var result = await pickImages();
      _images = result;
      notifyListeners();
    } catch (e) {
      debugPrint("selectImage issue =${e.toString()}");
    }
  }

  void sellProduct(BuildContext context, String name, String description,
      String price, String quantity) async {
    _isLoading = true;
    notifyListeners();

    _isSaved = await adminServices.sellProduct(
        context: context,
        name: name,
        description: description,
        price: double.parse(price),
        quantity: double.parse(quantity),
        category: category ?? 'Laptop',
        images: images);

    if (context.mounted) {
      showSnackBar(context, "Product Added successfully", isError: false);
      Provider.of<AdminProvider>(context, listen: false).fetchProducts(context);
      Navigator.pop(context);
    }

    _isLoading = false;
    notifyListeners();
    _images = [];
  }
}

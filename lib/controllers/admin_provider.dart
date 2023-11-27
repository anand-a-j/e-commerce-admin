import 'package:e_commerce_admin/models/orders.dart';
import 'package:e_commerce_admin/models/product.dart';
import 'package:e_commerce_admin/models/sales_model.dart';
import 'package:e_commerce_admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  final AdminServices adminServices = AdminServices();

  bool _isLoading = false;
  List<ProductModel>? _products = [];
  List<Order>? _orders = [];
  Map<String, dynamic> _earnings = {};
  int _totalSales = 0;
  List<Sales> _sales = [];
  int _currentStep = 0;

  bool get isLoading => _isLoading;
  List<ProductModel>? get products => _products;
  List<Order>? get orders => _orders;
  Map<String, dynamic> get earnings => _earnings;
  int get totalSales => _totalSales;
  List<Sales> get sales => _sales;
  int get currentStep => _currentStep;

  setOrderStatus(int value) {
    _currentStep = value;
  }

  fetchProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _products = await adminServices.fetchAllProducts(context);

    _isLoading = false;
    notifyListeners();
  }

  fetchOrders(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _orders = await adminServices.fetchAllOrders(context);

    _isLoading = false;
    notifyListeners();
  }

  deleteProduct(
      BuildContext context, ProductModel product, VoidCallback onSuccess) {
    adminServices.deleteProduct(
        context: context, product: product, onSuccess: onSuccess);
  }

  fetchEarnings(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _earnings = await adminServices.fetchEarnings(context);
    _totalSales = earnings['totalEarnings'];
    _sales = earnings['sales'];

    _isLoading = false;
    notifyListeners();
  }

  // only admin feature
  void changeOrderStatus(BuildContext context, Order order) {
    adminServices.changeOrderStatus(
        context: context,
        status: currentStep + 1,
        order: order,
        onSuccess: () {
          _currentStep += 1;
        });
    notifyListeners();
  }
}

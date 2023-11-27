
import 'package:e_commerce_admin/services/admin_services.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/view/analytics/screen/analytics_screen.dart';
import 'package:e_commerce_admin/view/product/screen/posts_screen.dart';
import 'package:e_commerce_admin/view/order/screen/orders_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ValueNotifier<int> selectedIndex = ValueNotifier(0);

    List<Widget> pages = const [
      PostsScreen(),
      AnalyticsScreen(),
      OrderScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("E Commerce Admin"),
        actions: [
          IconButton(
              onPressed: () {
                AdminServices().logOut(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: GlobalVariables.backgroundColor,
              ),)
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, updatedIndex, _) {
          return pages[updatedIndex];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, updatedIndex, _) {
            return BottomNavigationBar(
                currentIndex: updatedIndex,
                onTap: (index) {
                  selectedIndex.value = index;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), 
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.analytics), 
                      label: "Analytics"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_box), 
                      label: "Orders")
                ]);
          }),
    );
  }
}

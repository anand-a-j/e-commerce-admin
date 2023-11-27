import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/view/analytics/widget/bar_chart.dart';
import 'package:e_commerce_admin/view/analytics/widget/category_sum_container.dart';
import 'package:e_commerce_admin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).fetchEarnings(context);
    });
    return Consumer<AdminProvider>(
      builder: (context,admin,_) {
        return admin.isLoading
            ? const Loader()
            : ListView(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 95, 202, 98),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Sales",
                          style: TextStyle(
                              color: GlobalVariables.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        Text(
                          "₹ ${admin.totalSales}",
                          style: const TextStyle(
                              color: GlobalVariables.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  CategoryWiseSalesChart(
                    sales: admin.sales,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: admin.sales.length,
                      itemBuilder: (context, index) {
                        return CategoryWiseSumContainer(
                            title: admin.sales[index].label,
                            amount: admin.sales[index].earning.toString()
                        );
                      })
                ],
              );
      }
    );
  }
}


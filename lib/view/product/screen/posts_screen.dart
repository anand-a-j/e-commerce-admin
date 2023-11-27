import 'package:e_commerce_admin/controllers/admin_provider.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:e_commerce_admin/view/product/screen/add_product_screen.dart';
import 'package:e_commerce_admin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../admin/widget/post_product_container.dart';

class PostsScreen extends StatelessWidget {
  static const String routeName = 'post-screen';
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).fetchProducts(context);
    });
    return Scaffold(
      body: Consumer<AdminProvider>(builder: (context, admin, _) {
        return admin.products == null
            ? const Loader()
            : admin.products!.isEmpty
                ? const Center(
                    child: Text("No Products Added.."),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: admin.products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2.0 / 2.5),
                    itemBuilder: (context, index) {
                      final product = admin.products![index];
                      return ProductContainer(
                        product: product,
                        onPressed: () =>
                            admin.deleteProduct(context, product, () {
                          admin.products!.removeAt(index);
                          showSnackBar(context, "Product deleted successfully");
                        }),
                      );
                    });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalVariables.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
        child: const Icon(Icons.add, color: GlobalVariables.backgroundColor),
      ),
    );
  }
}

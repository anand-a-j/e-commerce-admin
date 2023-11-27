import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_admin/controllers/add_product_provider.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:e_commerce_admin/widgets/custom_button.dart';
import 'package:e_commerce_admin/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Consumer<AddProductProvider>(builder: (context, addProduct, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  addProduct.images.isNotEmpty
                      ? CarouselSlider(
                          items: addProduct.images.map((image) {
                            return Builder(builder: (context) {
                              return Image.file(
                                image,
                                fit: BoxFit.cover,
                              );
                            });
                          }).toList(),
                          options:
                              CarouselOptions(height: 200, viewportFraction: 1))
                      : InkWell(
                          onTap: addProduct.selectImages,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.7,
                                    color: GlobalVariables.selectedNavBarColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_front,
                                    size: 42,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Add Product Image",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: nameController, hintText: "Product Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: "Description",
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    controller: priceController,
                    hintText: "Price",
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    controller: quantityController,
                    hintText: "Quantity",
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Stack(
                    children: [
                      CustomTextField(
                          controller: categoryController, hintText: "Category",isEnabled: true,),
                      Positioned(
                        right: 10,
                        child: DropdownButton(
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            // value: addProduct.category,
                            items:
                                addProduct.productCategory.map((String item) {
                              return DropdownMenuItem(
                                  value: item, child: Text(item));
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                categoryController.text = newValue;
                                addProduct.setSelectedCategory(newValue);
                              }
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    title: "Sell",
                    onPressed: () {
                      if (addProduct.images.isEmpty) {
                        showSnackBar(context, "Add Product Images");
                      } else {
                        if (_addProductFormKey.currentState!.validate()) {
                          addProduct.sellProduct(
                              context,
                              nameController.text.trim(),
                              descriptionController.text.trim(),
                              priceController.text.trim(),
                              quantityController.text.trim());
                        }
                      }
                    },
                    isLoading: addProduct.isLoading,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

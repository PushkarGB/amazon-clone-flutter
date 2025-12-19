import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textField.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/admin/add_product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String category = "Mobiles";
  List<File> productImages = [];

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _productNameController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
  }

  List<String> productCategories = GlobalVariables.categoryImages.map((i) {
    return i['title']!;
  }).toList();

  void selectProductImages() async {
    var res = await pickImages();
    setState(() {
      productImages = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            "Add Product",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          // automaticallyImplyLeading: true,
          // automaticallyImplyActions: true, //--> these are by default true and because them we see that back arrow which performs Navigator.pop() on press
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                productImages.isEmpty
                    ? GestureDetector(
                        onTap: selectProductImages,
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            radius: const Radius.circular(10),
                            dashPattern: [10, 4],
                            strokeCap: StrokeCap.round,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_outlined, size: 40),
                                SizedBox(height: 15),
                                Text(
                                  "Select Product Images",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : CarouselSlider(
                        items: productImages.map((image) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              image,
                              fit:BoxFit.cover,
                              height: 200,
                              ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                        ),
                      ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _productNameController,
                  hintText: "Product Name",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: "Description",
                  maxLines: 6,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _priceController,
                  hintText: "Price",
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _quantityController,
                  hintText: "Quantity",
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(text: "Add Product", onTap: () {}),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

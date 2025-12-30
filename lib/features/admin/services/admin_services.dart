import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String productName,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> productImages,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      //connecting to cloudinary
      final cloudinary = CloudinaryPublic(
        'ddqpxsmxm',
        'amazon_clone_upload_preset',
      );

      List<String> imageUrls = [];

      //Upload to cloudinary and save the urls
      for (int i = 0; i < productImages.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(productImages[i].path, folder: productName),
        );
        imageUrls.add(res.secureUrl);
      }

      //Save the information as a Model
      Product product = Product(
        productName: productName,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        productImages: imageUrls,
      );

      //Now save the product details in mongo db and instead of original image , save the urls
      //For this we will call an API
      http.Response res = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: product.toJson(),
      );

      //Handling http response
      httpErrorHandel(
        response: res,
        onSuccess: () {
          showSnackBar("Product Added Successfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  //Get All the Products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
      );

      httpErrorHandel(
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(e.toString());
    }

    return productList;
  }
}

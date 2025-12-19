import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Product Screen")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 125, 221, 216),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        tooltip: "Add a Product",
        onPressed: () => Navigator.pushNamed(context, AddProductScreen.routeName),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

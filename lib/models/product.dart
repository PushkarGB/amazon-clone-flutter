import 'dart:convert';

class Product {
  final String productName;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final List<String> productImages;
  final String? id;

  Product({
    required this.productName,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.productImages,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'productImages': productImages,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      productName: map['productName'] ?? '',
      description: map['description'] ?? '',
      price: double.tryParse(map['price']) ?? 0.0,
      quantity: int.tryParse(map['price']) ?? 0,
      category: map['category'] ?? '',
      productImages: map['productImages'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

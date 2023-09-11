import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productName, category, image, weight, brand, shopName;
  final num price, comparedPrice;
  final DocumentSnapshot document;

  Product({
    required this.productName,
    required this.category,
    required this.image,
    required this.weight,
    required this.brand,
    required this.shopName,
    required this.price,
    required this.comparedPrice,
    required this.document,
  });
}

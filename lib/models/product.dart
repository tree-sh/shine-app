import 'package:shine_app/enums/categories.dart';

class Product {
  final String name;
  final double price;
  final String image;
  final Categories category;
  
  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category
  });
}
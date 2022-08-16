import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
final  String id;
final  String name;
final  String category;
  int quantity;
final  String size;
final double tax;
final  double price;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.quantity,
      required this.size,
      required this.tax,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
        id: id,
        name: json['name'],
        category: json['category'],
        quantity: json['quantity'],
        size: json['size'],
        tax: json['tax'],
        price: json['price']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'size': size,
      'tax': tax,
      'price': price
    };
  }
}

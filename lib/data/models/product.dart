import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String category;
  String quantity;
  String size;
  String tax;
  double price;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.quantity,
      required this.size,
      required this.tax,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
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

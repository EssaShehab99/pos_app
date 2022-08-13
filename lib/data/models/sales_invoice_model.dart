import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_app/data/models/product.dart';

class SalesInvoiceModel {
  String id;
  List<Product> products;
  String customerId;
  double total;
  double tax;
  double netTotal;

  SalesInvoiceModel({
    required this.id,
    required this.products,
    required this.customerId,
    required this.total,
    required this.tax,
    required this.netTotal,
  });

  factory SalesInvoiceModel.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceModel(
      id: json['id'],
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product, json['id']))
          .toList(),
      customerId: json['customerId'],
      total: json['total'],
      tax: json['tax'],
      netTotal: json['netTotal'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((product) => product.toJson()).toList(),
      'customerId': customerId,
      'total': total,
      'tax': tax,
      'netTotal': netTotal,
    };
  }
}

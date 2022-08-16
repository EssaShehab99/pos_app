import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_app/data/models/product.dart';

class SalesInvoiceModel {
  String id;
  List<Product> products;
  String customerId;
  double total;
  double tax;
  double netTotal;
  String status;
  SalesInvoiceModel({
    required this.id,
    required this.products,
    required this.customerId,
    required this.total,
    required this.tax,
    required this.netTotal,
    required this.status,
  });

  factory SalesInvoiceModel.fromJson(Map<String, dynamic> json, String id) {
    return SalesInvoiceModel(
      id: id,
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product, product['id']))
          .toList(),
      customerId: json['customerId'],
      total: json['total'],
      tax: json['tax'],
      netTotal: json['netTotal'],
      status: json['status'] ?? 'sale',
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
      'status': status,
    };
  }
}

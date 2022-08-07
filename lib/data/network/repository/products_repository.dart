import 'package:cloud_firestore/cloud_firestore.dart';
import '/modules/products.dart';
import '../../models/product.dart';
import '../services/product_services.dart';
import '/data/network/repository/repository.dart';

class ProductRepository extends Repository<Product>{
  late ProductServices _productServices;
  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteItem(int id) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> findAllItems() {
    // TODO: implement findAllItems
    throw UnimplementedError();
  }

  @override
  Future init() {
     _productServices = ProductServices();
      return Future.value(null);
  }

  @override
  Future<Product> insertItem(Product object) async {
    DocumentReference<Object?> productDocument= await _productServices.addProduct(object);
    Product product = Product.fromJson(await productDocument.get() as Map<String, dynamic>);
    return product;
  }

  @override
  Future<void> updateItem(Product object) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  @override
  Stream<List<Product>> watchAllItems() {
    // TODO: implement watchAllItems
    throw UnimplementedError();
  }
 
}
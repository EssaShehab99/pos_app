import 'package:cloud_firestore/cloud_firestore.dart';
import '/modules/products.dart';
import '../../models/product.dart';
import '../services/product_services.dart';
import '/data/network/repository/repository.dart';

class ProductRepository extends Repository<Product>{
  late ProductServices  _productServices ;
  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteItem(String id) async {
   await _productServices.deleteItem(id);
   return Future.value(null);
  }

  @override
  Future<List<Product>> findAllItems() async {
    List<DocumentReference<Object?>> products =
        await _productServices.showProducts();
    List<Product> productsList = [];
    for (var product in products) {
      DocumentSnapshot<Object?> productDocument = await product.get();
      if(productDocument.data() != null){
        productsList.add(Product.fromJson(
            productDocument.data() as Map<String, dynamic>,
            productDocument.id));
      }
    }
    return productsList;
  }

  @override
  Future init(String companyUUid) async {
     _productServices = ProductServices(companyUUid);
      return Future.value(null);
  }

  @override
  Future<Product> insertItem(Product object) async {
    DocumentReference<Object?> productDocument= await _productServices.addProduct(object);
    DocumentSnapshot<Object?> productSnapshot=await productDocument.get();
    Product product = Product.fromJson(productSnapshot.data() as Map<String, dynamic>,productSnapshot.id);
    return product;
  }

  @override
  Future<void> updateItem(Product object) {
    return _productServices.updateProduct(object);
  }

  @override
  Stream<List<Product>> watchAllItems() {
    // TODO: implement watchAllItems
    throw UnimplementedError();
  }
  Future<List<Product>> findAllItemsByCategory(String categoryName) async {
    List<DocumentReference<Object?>> products =
        await _productServices.showProductsByCategory(categoryName);
    List<Product> productsList = [];
    for (var product in products) {
      DocumentSnapshot<Object?> productDocument = await product.get();
      if(productDocument.data() != null){
        productsList.add(Product.fromJson(
            productDocument.data() as Map<String, dynamic>,
            productDocument.id));
      }
    }
    return productsList;
  }
}
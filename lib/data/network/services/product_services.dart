import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product.dart';

class ProductServices extends ChangeNotifier {
  late CollectionReference collection ;
  ProductServices(String companyUUid){
    collection = FirebaseFirestore.instance.collection(companyUUid).doc('data').collection('products');
  }
  Future<List<DocumentReference<Object?>>> showProducts() async{
    return await collection.get().then((value) => value.docs.map((e) => e.reference).toList());
  }
  Future<DocumentReference<Object?>> addProduct(Product product) async{
 return  await collection.add(product.toJson());
  }
  Future<void> deleteItem(String id) async{
    await collection.doc(id).delete();
  }
  Future<void> updateProduct(Product product) async{
    await collection.doc(product.id).update(product.toJson());
  }
  Future<List<DocumentReference<Object?>>> showProductsByCategory(String categoryName) async{
    return await collection.where('category',isEqualTo: categoryName).get().then((value) => value.docs.map((e) => e.reference).toList());
  }
}
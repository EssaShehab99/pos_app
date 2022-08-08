import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product.dart';

class ProductServices extends ChangeNotifier {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('products');

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
}
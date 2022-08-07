import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product.dart';

class ProductServices extends ChangeNotifier {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('products');

  Future<QuerySnapshot<Object?>> showProducts() async{
    return await collection.get();
  }
  Future<DocumentReference<Object?>> addProduct(Product product) async{
 return  await collection.add(product.toJson());
  }
  Future<void> removeProduct(String id) async{
    await collection.doc(id).delete();
  }
  Future<void> updateProduct(Product product) async{
    await collection.doc(product.id).update(product.toJson());
  }
}
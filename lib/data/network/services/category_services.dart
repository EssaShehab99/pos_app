import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/category.dart';

class CategoryServices {
  late CollectionReference collection ;
   CategoryServices(String companyUUid){
    collection = FirebaseFirestore.instance.collection('$companyUUid-categories');
  }
  Future<List<DocumentReference<Object?>>> showCategories() async {
    try{
      return await collection
          .get()
          .then((value) => value.docs.map((e) => e.reference).toList());
    }catch(e){
      return [];
    }
  }
  Future<DocumentReference<Object?>> addCategory(Category category) async {
    return await collection.add(category.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updateCategory(Category category) async {
    await collection.doc(category.id).update(category.toJson());
  }
}

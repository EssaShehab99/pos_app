import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/category.dart';

class CategoryServices {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('categories');
  Future<List<DocumentReference<Object?>>> findAllCategories() async {
    return await collection.get().then((value) {
      return value.docs.map((e) => e.reference).toList();
    });
  }
  Future<DocumentReference<Object?>> addCategory(Category category) async {
    return await collection.add(category.toJson());
  }

  Future<void> removeCategory(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updateCategory(Category category) async {
    await collection.doc(category.id).update(category.toJson());
  }
}

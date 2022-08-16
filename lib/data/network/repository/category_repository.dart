import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';
import '../services/category_services.dart';
import '/data/network/repository/repository.dart';

class CategoryRepository extends ChangeNotifier
    implements Repository<Category> {

  late CategoryServices _categoryServices;

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteItem(String id) async {
    await _categoryServices.deleteItem(id);
    return Future.value(null);
  }

  @override
  Future<List<Category>> findAllItems() async {
    List<DocumentReference<Object?>> categories =
        await _categoryServices.showCategories();
    List<Category> categoriesList = [];
    for (var category in categories) {
      DocumentSnapshot<Object?> categoryDocument = await category.get();
      categoriesList.add(Category.fromJson(
          categoryDocument.data() as Map<String, dynamic>,
          categoryDocument.id));
    }
    return categoriesList;
  }

  @override
  Future init(String companyUUid) async {
    _categoryServices = CategoryServices(companyUUid);
    return Future.value(null);
  }

  @override
  Future<Category> insertItem(Category object) async {
    DocumentReference<Object?> categoryDocument =
        await _categoryServices.addCategory(object);
    DocumentSnapshot<Object?> categorySnapshot = await categoryDocument.get();
    Category category = Category.fromJson(
        categorySnapshot.data() as Map<String, dynamic>, categorySnapshot.id);
    return category;
  }

  @override
  Future<void> updateItem(Category object) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  @override
  Stream<List<Category>> watchAllItems() {
    // TODO: implement watchAllItems
    throw UnimplementedError();
  }

  @override
  Future<Category?> findItemById(String id) async {
    var category =await _categoryServices.findCategoryById(id);
    if(category.data() != null){
      return Category.fromJson(category.data() as Map<String, dynamic>,category.id);
    }
  }
}

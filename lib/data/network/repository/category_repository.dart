import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';
import '../services/category_services.dart';
import '/data/network/repository/repository.dart';

class CategoryRepository extends ChangeNotifier implements Repository<Category>{
 late CategoryServices _categoryServices=CategoryServices();

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
  Future<List<Category>> findAllItems() async {
  List<DocumentReference<Object?>> categories=await _categoryServices.findAllCategories();
  List<Category> categoriesList=[];
for(var category in categories){
 categoriesList.add(Category.fromJson((await category.get()).data() as Map<String, dynamic>));
}
    return categoriesList;
  }

 @override
 Future init() {
   _categoryServices = CategoryServices();
   return Future.value(null);
 }

  @override
  Future<Category> insertItem(Category object) async {
   DocumentReference<Object?> categoryDocument= await _categoryServices.addCategory(object);
    Category category = Category.fromJson((await categoryDocument.get()).data() as Map<String, dynamic>);
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

}
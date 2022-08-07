import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../network/repository/category_repository.dart';

class ProductManager extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];
  CategoryRepository _categoryRepository = CategoryRepository();
  Future<void> addCategory(Category category) async {
    categories.add(await _categoryRepository.insertItem(category));
    notifyListeners();
  }
  Future<void> getCategories() async {
    categories = await _categoryRepository.findAllItems();
    notifyListeners();
  }

}

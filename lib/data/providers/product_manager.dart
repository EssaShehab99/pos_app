import 'package:flutter/material.dart';
import 'package:pos_app/data/network/repository/products_repository.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../network/repository/category_repository.dart';

class ProductManager extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];
  final CategoryRepository _categoryRepository = CategoryRepository();
  final ProductRepository _productRepository = ProductRepository();
  Future<void> addCategory(Category category) async {
    categories.add(await _categoryRepository.insertItem(category));
    notifyListeners();
  }
  Future<void> getCategories() async {
    categories = await _categoryRepository.findAllItems();
    notifyListeners();
  }
  Future<void> addProduct(Product product) async {
    products.add(await _productRepository.insertItem(product));
    notifyListeners();
  }
  Future<void> deleteCategory(String id) async {
    await _categoryRepository.deleteItem(id);
    categories.removeWhere((category) => category.id == id);
    notifyListeners();
  }
}

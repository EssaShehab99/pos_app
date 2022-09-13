import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:pos_app/data/network/repository/products_repository.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../network/repository/category_repository.dart';

class ProductManager extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> filterProducts = [];
  String companyUUid = "";
  late CategoryRepository _categoryRepository;

  late ProductRepository _productRepository;

  void init(String companyUUid) {
    _categoryRepository = CategoryRepository()..init(companyUUid);
    _productRepository = ProductRepository()..init(companyUUid);
  }

  Future<void> addCategory(Category category) async {
    await _categoryRepository.insertItem(category);
    await getCategories();
    notifyListeners();
  }

  Future<void> getCategories() async {
    categories = await _categoryRepository.findAllItems();
    notifyListeners();
  }

  Future<void> getProducts() async {
    products = await _productRepository.findAllItems();
    filterProducts = products;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    products.add(await _productRepository.insertItem(product));
    filterProducts = products;
    notifyListeners();
  }

  Future<void> updateItem(Product product) async {
    products.removeWhere((element) => element.id == product.id);
    _productRepository.updateItem(product);
    await getProducts();
    notifyListeners();
  }

  Future<void> deleteCategory(String id) async {
    await _categoryRepository.deleteItem(id);
    categories.removeWhere((category) => category.id == id);
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    await _productRepository.deleteItem(id);
    products.removeWhere((product) => product.id == id);
    filterProducts = products;
    notifyListeners();
  }

  String? getCategoryName(String id) {
    return categories.firstWhereOrNull((category) => category.id == id)?.name;
  }
  void searchProduct(String name) {
    filterProducts = products.where((product) => product.name.contains(name)).toList();
    notifyListeners();
  }
}

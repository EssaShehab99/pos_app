import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/network/repository/customer_repository.dart';
import 'package:pos_app/data/network/repository/products_repository.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/sales_invoice_model.dart';
import '../network/repository/category_repository.dart';

class SalesInvoiceManager extends ChangeNotifier {
  List<Category> categories = [];
  String? selectedCategoryId;
  List<Product> products = [];
  List<Product> filterProducts = [];
  SalesInvoiceModel? salesInvoice;
  final CategoryRepository _categoryRepository = CategoryRepository();
  final ProductRepository _productRepository = ProductRepository();

  Future<void> getCategories() async {
    categories = await _categoryRepository.findAllItems();
    categories.insert(0,Category(id: "0", name: 'all'.tr()));
    selectedCategoryId = categories[0].id;
    notifyListeners();
  }
  Future<void> getProducts() async {
    products = await _productRepository.findAllItems();
    notifyListeners();
  }
  Future<void> getProductsByCategory(Category category) async {
    if(category.id == "0") {
       await getProducts();
      filterProducts = products;
      selectCategory(category.id);
      notifyListeners();
    return;
    }
    products = await _productRepository.findAllItemsByCategory(category.name);
    filterProducts = products;
    selectCategory(category.id);
    notifyListeners();
  }
  Future<void>  getProductsAndCategories() async {
    await getCategories();
    await getProducts();
    filterProduct();
  }
  void filterProduct({String search = ""}) {
    filterProducts = products.where((product) => product.name.contains(search)).toList();
    notifyListeners();
  }
  void selectCategory(String id) {
    selectedCategoryId = id;
    notifyListeners();
  }
  void addLocalSalesInvoice(String productID) {
    if(salesInvoice!=null) {
      for (var element in salesInvoice!.products) {
        print("${element.id} // ${productID}");
        if (element.id == productID) {
          element.quantity++;
          salesInvoice!.total = salesInvoice!.products.fold(0, (total, product) => total + product.price * product.quantity);
          salesInvoice!.tax = salesInvoice!.total * 0.1;
          salesInvoice!.netTotal = salesInvoice!.total + salesInvoice!.tax;
          notifyListeners();
          return;
        }
      }
      salesInvoice!.products.add(products.firstWhere((product) => product.id == productID)..quantity=1);
      salesInvoice!.total = salesInvoice!.products.fold(0, (total, product) => total + product.price * product.quantity);
      salesInvoice!.tax = salesInvoice!.total * 0.1;
      salesInvoice!.netTotal = salesInvoice!.total + salesInvoice!.tax;
      notifyListeners();
      return;
    }
    else {
      salesInvoice=SalesInvoiceModel(
      id: "",
      products: [products.firstWhere((product) => product.id == productID)..quantity=1],
      customerId: "",
      total: 0,
      tax: 0,
      netTotal: 0,
    );
      salesInvoice!.total = salesInvoice!.products.fold(0, (total, product) => total + product.price * product.quantity);
      salesInvoice!.tax = salesInvoice!.total * 0.1;
      salesInvoice!.netTotal = salesInvoice!.total + salesInvoice!.tax;
      notifyListeners();
    }
  }
}

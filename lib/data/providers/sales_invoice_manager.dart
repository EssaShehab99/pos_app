import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:pos_app/data/data_response.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/network/repository/customer_repository.dart';
import 'package:pos_app/data/network/repository/products_repository.dart';
import 'package:pos_app/data/network/repository/sales_invoice_repository.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/sales_invoice_model.dart';
import '../network/repository/category_repository.dart';
import '../network/services/category_services.dart';

class SalesInvoiceManager extends ChangeNotifier {
  List<Customer> customers = [];
  List<Category> categories = [];
  String? selectedCategoryId;
  List<Product> products = [];
  List<Product> filterProducts = [];
  bool isCash = true;
  SalesInvoiceModel? salesInvoice;
  late CategoryRepository _categoryRepository;
  late ProductRepository _productRepository;
  late CustomerRepository _customerRepository;
  late SalesInvoiceRepository _salesInvoiceRepository;
  void init(String companyUUid) {
    _categoryRepository = CategoryRepository()..init(companyUUid);
    _productRepository = ProductRepository()..init(companyUUid);
    _customerRepository = CustomerRepository()..init(companyUUid);
    _salesInvoiceRepository = SalesInvoiceRepository()..init(companyUUid);
  }

  Future<void> getCategories() async {
    categories = await _categoryRepository.findAllItems();
    categories.insert(0, Category(id: "0", name: 'all'.tr()));
    selectedCategoryId = categories[0].id;
    notifyListeners();
  }

  Future<void> getProducts() async {
    products = await _productRepository.findAllItems();
    notifyListeners();
  }

  Future<List<Customer>> getCustomers() async {
    customers = await _customerRepository.findAllItems();
    return customers;
  }
  Future<List<String>> getCustomersByName(String name) async {
    customers = await _customerRepository.findAllItemsByName(name);
    return customers.map((e) => e.name).toList();
  }
  Future<void> getProductsByCategory(Category category) async {
    if (category.id == "0") {
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
  Future<void> getProductsAndCategories() async {
    await getCategories();
    await getProducts();
    await getCustomers();
    filterProduct();
  }
  void filterProduct({String search = ""}) {
    filterProducts =
        products.where((product) => product.name.contains(search)).toList();
    notifyListeners();
  }
  void selectCategory(String id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  Result<bool> addLocalSalesInvoice(String? productID) {
    if (productID != null) {
     late bool status;
      Product product = products.firstWhere((product) => product.id == productID);
      if (salesInvoice != null) {
        for (var element in salesInvoice!.products) {
          if (element.id == productID) {
            status=checkEnoughQuantity(productID, element.quantity+1);
              if(status) {
                element.quantity++;
                salesInvoice!.total = salesInvoice!.products.fold(0,
                        (total, product) =>
                    total + product.price * (product.quantity));
                salesInvoice!.tax = salesInvoice!.total * 0.1;
                salesInvoice!.netTotal =
                    salesInvoice!.total + salesInvoice!.tax;
                notifyListeners();
                return Success(true);
              }
              else{
                notifyListeners();
                return Error(exception: Exception('not-enough-quantity'.tr()));
              }
          }
        }
        status=checkEnoughQuantity(productID, 1);
        if(status) {
          salesInvoice!.products.add(
              Product(id: product.id,
                  name: product.name,
                  price: product.price,
                  tax: product.tax,
                  quantity: 1,
                  category: product.category,
                  size: product.size));
          salesInvoice!.total = salesInvoice!.products.fold(
              0, (total, product) => total + product.price * product.quantity);
          salesInvoice!.tax = salesInvoice!.total * 0.1;
          salesInvoice!.netTotal = salesInvoice!.total + salesInvoice!.tax;
          notifyListeners();
          return Success(true);
        }
        else{
          notifyListeners();
          return Error(exception: Exception('not-enough-quantity'.tr()));
        }
      } else {
        bool status=checkEnoughQuantity(productID, 1);
         if(status) {
           salesInvoice = SalesInvoiceModel(
             id: "",
             status: "sale",
             products: [
               Product(id: product.id,
                   name: product.name,
                   price: product.price,
                   tax: product.tax,
                   quantity: 1,
                   category: product.category,
                   size: product.size)
             ],
             customerId: "",
             total: 0,
             tax: 0,
             netTotal: 0,
           );
           salesInvoice!.total = salesInvoice!.products.fold(
               0, (total, product) => total + product.price * product.quantity);
           salesInvoice!.tax = salesInvoice!.total * 0.1;
           salesInvoice!.netTotal = salesInvoice!.total + salesInvoice!.tax;
           notifyListeners();
           return Success(true);
         }
         else{
           notifyListeners();
           return Error(exception: Exception('not-enough-quantity'.tr()));
         }
      }
    }
    notifyListeners();
    return Error(exception: Exception('product-not-found'.tr()));
  }
bool checkEnoughQuantity(String productID, int quantity) {
    Product product = products.firstWhere((product) => product.id == productID);
    if (product.quantity >= quantity) {
      return true;
    } else {
      return false;
    }
  }
  void deleteInvoice() {
    salesInvoice = null;
    notifyListeners();
  }

  void removeProduct(String? productID) {
    if (salesInvoice != null) {
      for (var element in salesInvoice!.products) {
        if (element.id == productID) {
          if (element.quantity > 1) {
            element.quantity--;
            salesInvoice!.total = salesInvoice!.products.fold(0,
                (total, product) => total + product.price * product.quantity);
            salesInvoice!.tax = salesInvoice!.total * 0.1;
            salesInvoice!.netTotal = salesInvoice!.total + salesInvoice!.tax;
            notifyListeners();
            return;
          } else {
            salesInvoice!.products.remove(element);
            salesInvoice!.total = salesInvoice!.products.fold(0,
                (total, product) => total + product.price * product.quantity);
            salesInvoice!.tax = salesInvoice!.total * 0.1;
            salesInvoice!.netTotal = salesInvoice!.total + salesInvoice!.tax;
            notifyListeners();
            return;
          }
        }
      }
    }
  }

  void selectPaymentMethod(bool isCash) {
    this.isCash = isCash;
    notifyListeners();
  }
  void setCustomer(Customer customer) async {
  salesInvoice?.customerId=customer.id;
  }
  Future<Result<bool>> saveInvoice() async {
    if (salesInvoice != null) {
      try{
        Customer customer = customers
            .firstWhere((customer) => customer.id == salesInvoice?.customerId);
        if (isCash) {
          customer.debit = customer.debit! + salesInvoice!.netTotal;
          customer.credit = customer.credit! + salesInvoice!.netTotal;
        } else {
          customer.debit = customer.debit! + salesInvoice!.netTotal;
        }
        for (var product in salesInvoice!.products) {
          Product mainProduct =
              products.firstWhere((item) => item.id == product.id);
          mainProduct.quantity = mainProduct.quantity - product.quantity;
          await _productRepository.updateItem(mainProduct);
        }
        await _customerRepository.updateItem(customer);
        await _salesInvoiceRepository.insertItem(salesInvoice!);
        return Success(true);
      }catch(e){
        return Error(exception: Exception(e));
      }
    }
    return Error(exception: Exception("no-product-found".tr()));
  }
  Future<List<SalesInvoiceModel>> getSalesInvoice() async {
    await getCustomers();
    return await _salesInvoiceRepository.findAllItems();
  }
  String getCustomerById(String id) {
    return customers.firstWhere((customer) => customer.id == id).name;
  }

  String? getCustomerName(String id) {
    return customers.firstWhereOrNull((customer) => customer.id == id)?.name;
  }
}

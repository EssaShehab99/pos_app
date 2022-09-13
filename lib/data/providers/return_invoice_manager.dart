import 'package:flutter/material.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/network/repository/customer_repository.dart';
import 'package:pos_app/data/network/repository/products_repository.dart';
import 'package:pos_app/data/network/repository/sales_invoice_repository.dart';

import '../models/product.dart';
import '../models/sales_invoice_model.dart';
class ReturnInvoiceManager extends ChangeNotifier {
  late SalesInvoiceRepository _salesInvoiceRepository;
  bool isLoading = false;
  late ProductRepository _productRepository;
  late CustomerRepository _customerRepository;

  void init(String companyUUid) {
    _customerRepository = CustomerRepository()..init(companyUUid);
    _salesInvoiceRepository = SalesInvoiceRepository()..init(companyUUid);
    _productRepository = ProductRepository()..init(companyUUid);
  }
  Future<Customer?> getCustomerByID(String id) async {
    return await _customerRepository.findItemById(id);
  }
  Future<Product?> getProductByID(String id) async {
    return await _productRepository.findItemById(id);
  }
  Future<void> setReturnInvoice(SalesInvoiceModel salesInvoice) async {
    salesInvoice.status = 'return';
    Customer? customer = await getCustomerByID(salesInvoice.customerId);
    if (customer != null) {
      customer.credit = customer.credit! + salesInvoice.netTotal;
    await  _customerRepository.updateItem(customer);
    }
    for(var item in salesInvoice.products) {
      Product? product = await getProductByID(item.id);
      if (product != null) {
        product.quantity = product.quantity + item.quantity;
        await _productRepository.updateItem(product);
      }
    }
    await _salesInvoiceRepository.updateItem(salesInvoice);

    return Future.value();
  }

  void refresh() {
    isLoading=!isLoading;
    notifyListeners();
  }
}

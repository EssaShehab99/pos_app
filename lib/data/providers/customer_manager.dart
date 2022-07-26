import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/network/repository/customer_repository.dart';

class CustomerManager extends ChangeNotifier {
  List<Customer> customers = [];
  late CustomerRepository _customerRepository;
  void init(String companyUUid) {
    _customerRepository = CustomerRepository()..init(companyUUid);
  }
  Future<void> getCustomers() async {
    customers = await _customerRepository.findAllItems();
   if(customers.isNotEmpty){
     notifyListeners();
   }
  }
  Future<void> addCustomer(Customer customer) async {
    customers.add(await _customerRepository.insertItem(customer));
    notifyListeners();
  }
  Future<void> updateItem(Customer customer) async {
    customers.removeWhere((element) => element.id == customer.id);
    _customerRepository.updateItem(customer);
    await getCustomers();
    notifyListeners();
  }
  Future<void> deleteCustomer(String id) async {
    await _customerRepository.deleteItem(id);
    customers.removeWhere((category) => category.id == id);
    notifyListeners();
  }
  String? getCustomerName(String id) {
    return customers.firstWhereOrNull((customer) => customer.id == id)?.name;
  }
}

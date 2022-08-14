import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/network/services/customer_services.dart';
import '/modules/products.dart';
import '../../models/product.dart';
import '../services/product_services.dart';
import '/data/network/repository/repository.dart';

class CustomerRepository extends Repository<Customer>{
  late CustomerServices _customerServices ;
  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteItem(String id) async {
   await _customerServices.deleteItem(id);
   return Future.value(null);
  }

  @override
  Future<List<Customer>> findAllItems() async {
    List<DocumentReference<Object?>> customers =
        await _customerServices.showCustomers();
    List<Customer> customersList = [];
    for (var customer in customers) {
      DocumentSnapshot<Object?> customerDocument = await customer.get();
      if(customerDocument.data() != null){
        customersList.add(Customer.fromJson(
            customerDocument.data() as Map<String, dynamic>,
            customerDocument.id));
      }
    }
    return customersList;
  }
  Future<List<Customer>> findAllItemsByName(String name) async {
    List<DocumentReference<Object?>> customers =
        await _customerServices.showCustomers();
    List<Customer> customersList = [];
    for (var customer in customers) {
      DocumentSnapshot<Object?> productDocument = await customer.get();
      if(productDocument.data() != null){
        customersList.add(Customer.fromJson(
            productDocument.data() as Map<String, dynamic>,
            productDocument.id));
      }
    }
    return customersList;
  }
  @override
  Future init(String companyUUid) async {
      _customerServices = CustomerServices(companyUUid);
      return Future.value(null);
  }

  @override
  Future<Customer> insertItem(Customer object) async {
    DocumentReference<Object?> customerDocument= await _customerServices.addCustomer(object);
    DocumentSnapshot<Object?> customerSnapshot=await customerDocument.get();
    Customer customer = Customer.fromJson(customerSnapshot.data() as Map<String, dynamic>,customerSnapshot.id);
    return customer;
  }

  @override
  Future<void> updateItem(Customer object) {
    return _customerServices.updateCustomer(object);
  }

  @override
  Stream<List<Customer>> watchAllItems() {
    // TODO: implement watchAllItems
    throw UnimplementedError();
  }


}
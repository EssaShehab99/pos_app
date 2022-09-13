import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/customer.dart';

class CustomerServices extends ChangeNotifier {
  late CollectionReference collection;

  CustomerServices(String companyUUid) {
    collection =
        FirebaseFirestore.instance.collection(companyUUid).doc('data').collection('customers');
  }

  Future<List<DocumentReference<Object?>>> showCustomers() async {
    return await collection
        .get()
        .then((value) => value.docs.map((e) => e.reference).toList());
  }
  Future<List<DocumentReference<Object?>>> showCustomersByName(String name) async {
    return await collection
        .where('name', arrayContains: name)
        .get()
        .then((value) => value.docs.map((e) => e.reference).toList());
  }
  Future<DocumentReference<Object?>> addCustomer(Customer customer) async {
    return await collection.add(customer.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updateCustomer(Customer customer) async {
    await collection.doc(customer.id).update(customer.toJson());
  }
  Future<DocumentSnapshot<Object?>> findCustomerById(String id) async {
    return await collection.doc(id).get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/customer.dart';
import '../../models/product.dart';

class CustomerServices extends ChangeNotifier {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('customers');

  Future<List<DocumentReference<Object?>>> showCustomers() async{
    return await collection.get().then((value) => value.docs.map((e) => e.reference).toList());
  }
  Future<DocumentReference<Object?>> addCustomer(Customer customer) async{
 return  await collection.add(customer.toJson());
  }
  Future<void> deleteItem(String id) async{
    await collection.doc(id).delete();
  }
  Future<void> updateCustomer(Customer customer) async{
    await collection.doc(customer.id).update(customer.toJson());
  }
}
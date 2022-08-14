import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pos_app/data/models/sales_invoice_model.dart';
import 'package:pos_app/modules/sales_invoice.dart';

import '../../models/customer.dart';
import '../../models/product.dart';

class SalesInvoiceServices extends ChangeNotifier {
  late CollectionReference collection;

  SalesInvoiceServices(String companyUUid) {
    collection =
        FirebaseFirestore.instance.collection(companyUUid).doc("data").collection('sales_invoices');
  }

  Future<List<DocumentReference<Object?>>> showSalesInvoice() async {
    return await collection
        .get()
        .then((value) => value.docs.map((e) => e.reference).toList());
  }
  Future<DocumentReference<Object?>> addSalesInvoice(SalesInvoiceModel salesInvoice) async {
    return await collection.add(salesInvoice.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updateSalesInvoice(SalesInvoiceModel salesInvoice) async {
    await collection.doc(salesInvoice.id).update(salesInvoice.toJson());
  }

}

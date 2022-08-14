import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/models/sales_invoice_model.dart';
import 'package:pos_app/data/network/services/customer_services.dart';
import 'package:pos_app/data/network/services/sales_invoice_services.dart';
import '/modules/products.dart';
import '../../models/product.dart';
import '../services/product_services.dart';
import '/data/network/repository/repository.dart';

class SalesInvoiceRepository extends Repository<SalesInvoiceModel>{
  late SalesInvoiceServices _invoiceServices;
  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteItem(String id) async {
   await _invoiceServices.deleteItem(id);
   return Future.value(null);
  }

  @override
  Future<List<SalesInvoiceModel>> findAllItems() async {
    List<DocumentReference<Object?>> invoices =
        await _invoiceServices.showSalesInvoice();
    List<SalesInvoiceModel> salesInvoices = [];
    for (var invoice in invoices) {
      DocumentSnapshot<Object?> invoiceDocument = await invoice.get();
      if(invoiceDocument.data() != null){
        salesInvoices.add(SalesInvoiceModel.fromJson(
            invoiceDocument.data() as Map<String, dynamic>,
            invoiceDocument.id));
      }
    }
    return salesInvoices;
  }
  @override
  Future init(String companyUUid) async {
      _invoiceServices = SalesInvoiceServices(companyUUid);
      return Future.value(null);
  }

  @override
  Future<SalesInvoiceModel> insertItem(SalesInvoiceModel object) async {
    DocumentReference<Object?> salesInvoiceDocument= await _invoiceServices.addSalesInvoice(object);
    DocumentSnapshot<Object?> salesInvoiceSnapshot=await salesInvoiceDocument.get();
    SalesInvoiceModel salesInvoiceModel = SalesInvoiceModel.fromJson(salesInvoiceSnapshot.data() as Map<String, dynamic>,salesInvoiceSnapshot.id);
    return salesInvoiceModel;
  }

  @override
  Future<void> updateItem(SalesInvoiceModel object) {
    return _invoiceServices.updateSalesInvoice(object);
  }

  @override
  Stream<List<SalesInvoiceModel>> watchAllItems() {
    // TODO: implement watchAllItems
    throw UnimplementedError();
  }


}
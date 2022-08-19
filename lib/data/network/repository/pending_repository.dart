import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/data/models/pending_model.dart';
import 'package:pos_app/data/network/services/pending_services.dart';

import '../../models/category.dart';
import '../services/category_services.dart';
import '/data/network/repository/repository.dart';

class PendingRepository extends ChangeNotifier
    implements Repository<PendingModel> {

  late PendingServices _pendingServices;

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteItem(String id) async {
    await _pendingServices.deleteItem(id);
    return Future.value(null);
  }

  @override
  Future<List<PendingModel>> findAllItems() async {
  // TODO: implement findAllItems
    throw UnimplementedError();
  }
  Future<List<PendingModel>> findByReceiver(String accountReceiver) async {
    List<DocumentReference<Object?>> pending =
    await _pendingServices.showReceiverPending(accountReceiver);
    List<PendingModel> pendingList = [];
    for (var pend in pending) {
      DocumentSnapshot<Object?> pendingDocument = await pend.get();
      pendingList.add(PendingModel.fromJson(
          pendingDocument.data() as Map<String, dynamic>,
          pendingDocument.id));
    }
    return pendingList;
  }
  @override
  Future<PendingModel?> findItemById(String id) async {
    var pending =await _pendingServices.findPendingById(id);
    if(pending.data() != null){
      return PendingModel.fromJson(pending.data() as Map<String, dynamic>, pending.id);
    }
    return null;
  }

  @override
  Future init(String companyUUid) {
    _pendingServices = PendingServices();
    return Future.value(null);
  }

  @override
  Future<PendingModel> insertItem(PendingModel object) async {
    DocumentReference<Object?> pendingDocument =
        await _pendingServices.addPending(object);
    DocumentSnapshot<Object?> pendingSnapshot = await pendingDocument.get();
    PendingModel pending = PendingModel.fromJson(
        pendingSnapshot.data() as Map<String, dynamic>, pendingSnapshot.id);
    return pending;
  }

  @override
  Future<void> updateItem(PendingModel object) {
    return _pendingServices.updatePending(object);
  }

  @override
  Stream<List<PendingModel>> watchAllItems() {
    // TODO: implement watchAllItems
    throw UnimplementedError();
  }

}

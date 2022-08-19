import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pos_app/data/models/pending_model.dart';
import 'package:pos_app/data/models/user_model.dart';

import '../../models/category.dart';

class PendingServices {
  late CollectionReference collection ;
  PendingServices(){
    collection = FirebaseFirestore.instance.collection('pending');
  }
  Future<List<DocumentReference<Object?>>> showReceiverPending(String userId) async {
    try{
      return await collection.where('accountReceiver',isEqualTo: userId)
          .get()
          .then((value) => value.docs.map((e) => e.reference).toList());
    }catch(e){
      return [];
    }
  }
  Future<DocumentReference<Object?>> addPending(PendingModel pending) async {
    return await collection.add(pending.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updatePending(PendingModel pending) async {
    await collection.doc(pending.id).update(pending.toJson());
  }
  Future<DocumentSnapshot<Object?>> findPendingById(String id) async {
    return await collection.doc(id).get();
  }
}

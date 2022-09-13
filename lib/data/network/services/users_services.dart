import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_app/data/models/user_model.dart';


class UsersServices {
  late CollectionReference collection ;
  UsersServices(){
    collection = FirebaseFirestore.instance.collection('users');
  }
  Future<List<DocumentReference<Object?>>> showUsers() async {
    try{
      return await collection
          .get()
          .then((value) => value.docs.map((e) => e.reference).toList());
    }catch(e){
      return [];
    }
  }
  Future<List<DocumentReference<Object?>>> findItemByUuid(String uuid) async {
    try{
      return await collection
          .where('uuid', isEqualTo: uuid)
          .get()
          .then((value) => value.docs.map((e) => e.reference).toList());
    }catch(e){
      return [];
    }
  }
  Future<List<DocumentReference<Object?>>> findUserByEmail(String email) async {
    try{
      return await collection
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value.docs.map((e) => e.reference).toList());
    }catch(e){
      return [];
    }
  }
  Future<DocumentReference<Object?>> addUser(UserModel user) async {
    return await collection.add(user.toJson());
  }

  Future<void> deleteItem(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updateUser(UserModel user) async {
    await collection.doc(user.id).update(user.toJson());
  }
  Future<DocumentSnapshot<Object?>> findUserById(String id) async {
    return await collection.doc(id).get();
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/data/models/user_model.dart';
import 'package:pos_app/data/network/services/users_services.dart';

import '/data/network/repository/repository.dart';

class UserRepository extends ChangeNotifier
    implements Repository<UserModel> {
  late UsersServices _usersServices;

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<void> deleteItem(String id) async {
    await _usersServices.deleteItem(id);
    return Future.value(null);
  }

  @override
  Future<List<UserModel>> findAllItems() async {
    List<DocumentReference<Object?>> users =
        await _usersServices.showUsers();
    List<UserModel> usersList = [];
    for (var user in users) {
      DocumentSnapshot<Object?> userDocument = await user.get();
      usersList.add(UserModel.fromJson(
          userDocument.data() as Map<String, dynamic>, userDocument.id));
    }
    return usersList;
  }

  @override
  Future<UserModel?> findItemById(String id) async {
    var user =await _usersServices.findUserById(id);
    if (user.data() != null) {
      return UserModel.fromJson(user.data() as Map<String, dynamic>, user.id);
    }
    return null;
  }
  Future<List<UserModel>> findItemByEmail(String email) async {
    List<DocumentReference<Object?>> users =
        await _usersServices.findUserByEmail(email);
    List<UserModel> usersList = [];
    for (var user in users) {
      DocumentSnapshot<Object?> userDocument = await user.get();
      usersList.add(UserModel.fromJson(
          userDocument.data() as Map<String, dynamic>, userDocument.id));
    }
    return usersList;
  }
  Future<List<UserModel>> findItemByUuid(String uuid) async {
    var users =await _usersServices.findItemByUuid(uuid);
    List<UserModel> usersList = [];
    for (var user in users) {
      DocumentSnapshot<Object?> userDocument = await user.get();
      usersList.add(UserModel.fromJson(
          userDocument.data() as Map<String, dynamic>, userDocument.id));
    }
    return usersList;
  }

  @override
  Future init(String companyUUid) {
    _usersServices = UsersServices();
    return Future.value(null);
  }

  @override
  Future<UserModel> insertItem(UserModel object) async {
    DocumentReference<Object?> userDocument =
        await _usersServices.addUser(object);
    DocumentSnapshot<Object?> userSnapshot =
    await  userDocument.get();
    UserModel user = UserModel.fromJson(
        userSnapshot.data() as Map<String, dynamic>, userSnapshot.id);
    return Future.value(user);
  }

  @override
  Future<void> updateItem(UserModel object) {
    return _usersServices.updateUser(object);
  }

  @override
  Stream<List<UserModel>> watchAllItems() {
    // TODO: implement watchAllItems
    throw UnimplementedError();
  }


}

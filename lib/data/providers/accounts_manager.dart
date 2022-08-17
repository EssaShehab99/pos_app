import 'package:flutter/foundation.dart';
import 'package:pos_app/data/network/repository/user_repository.dart';

import '../models/pending_model.dart';
import '../models/user_model.dart';
import '../network/repository/pending_repository.dart';

class AccountsManager extends ChangeNotifier{
  List<UserModel> users = [];
  List<PendingModel> pending = [];
  late UserRepository _userRepository;
  late PendingRepository _pendingRepository;
 late UserModel userModel;
 late PendingModel pendingModel;
  void init(UserModel userModel) {
    this.userModel = userModel;
    _userRepository = UserRepository()..init(userModel.uuid!);
    _pendingRepository = PendingRepository()..init(userModel.uuid!);
  }
  Future<void> getUsers() async {
    users = await _userRepository.findItemByUuid(userModel.uuid!);
    if(users.isNotEmpty){
      notifyListeners();
    }
  }
  Future<List<UserModel>> getUsersByEmail(String email) async {
    users = await _userRepository.findItemByEmail(email);
    return users;
  }
  Future<void> getPending() async {
    pending = await _pendingRepository.findAllItems();
    if(pending.isNotEmpty){
      notifyListeners();
    }
  }
  Future<void> addPending(PendingModel pendingModel) async {
     await _pendingRepository.insertItem(pendingModel);
    notifyListeners();
  }
  Future<void> updatePending(PendingModel pendingModel) async {
    pending.removeWhere((element) => element.id == pendingModel.id);
    _pendingRepository.updateItem(pendingModel);
    await getPending();
    notifyListeners();
  }

  Future<void> updateUser(UserModel userModel) async {
    users.removeWhere((element) => element.id == userModel.id);
    _userRepository.updateItem(userModel);
    await getUsers();
    notifyListeners();
  }
  Future<void> deletePending(String id) async {
    await _pendingRepository.deleteItem(id);
    pending.removeWhere((category) => category.id == id);
    notifyListeners();
  }
  void setUserPending(String accountReceiver) async {
    pendingModel = PendingModel(id: "", accountSender: userModel.id??'', accountReceiver: accountReceiver,companyUUid: userModel.uuid!);
    notifyListeners();
  }
  Future<void> insertPending() async {
  await  _pendingRepository.insertItem(pendingModel);
    notifyListeners();
  }
}
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
 late String companyUUid;
  void init(String companyUUid) {
    this.companyUUid = companyUUid;
    _userRepository = UserRepository()..init(companyUUid);
    _pendingRepository = PendingRepository()..init(companyUUid);
  }
  Future<void> getUsers() async {
    users = await _userRepository.findItemByUuid(companyUUid);
    if(users.isNotEmpty){
      notifyListeners();
    }
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
}
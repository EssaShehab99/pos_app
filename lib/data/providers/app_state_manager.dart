import 'package:flutter/material.dart';
import 'package:pos_app/data/models/pending_model.dart';

import '../models/user_model.dart';
import '../network/services/auth_services.dart';
import '../setting/config_app.dart';


class AppStateManager extends ChangeNotifier{
  AuthServices authServices = AuthServices();
 late UserModel user;
  void setUser(UserModel user){
    this.user = user;
    notifyListeners();
  }
  Future<bool> autoSignIn() async {
    final List<String> emailAndPassword=  await ConfigApp.getEmailAndPassword();
    if(emailAndPassword.isNotEmpty){
      final user = await authServices.signIn(emailAndPassword[0], emailAndPassword[1]);
      if(user != null){
        this.user = user;
        return true;
      }
    }
    return false;
  }
  Future<bool> signIn(String email, String password) async {
    var user = await authServices.signIn(email, password);
    if(user != null){
      setUser(user);
      return true;
    }
    return false;
  }
}
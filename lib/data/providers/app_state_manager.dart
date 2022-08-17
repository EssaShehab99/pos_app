import 'package:flutter/material.dart';
import 'package:pos_app/data/models/pending_model.dart';

import '../models/user_model.dart';


class AppStateManager extends ChangeNotifier{
 late UserModel user;
  void setUser(UserModel user){
    this.user = user;
    notifyListeners();
  }
}
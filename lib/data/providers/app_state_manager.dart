import 'package:flutter/material.dart';

import '../models/user.dart';

class AppStateManager extends ChangeNotifier{
 late UserModel user;

  void setUser(UserModel user){
    this.user = user;
    notifyListeners();
  }
}
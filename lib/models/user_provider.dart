import 'package:flutter/material.dart';
import 'package:mybooks/utils/init.dart';
import 'package:mybooks/models/user.dart';

class MyUserModel extends ChangeNotifier {
  bool get isLogin => Init.profile.login;
  set isLogin(bool isLogin) {
    if (isLogin != Init.profile.login) {
      Init.profile.login = isLogin;
      Init.saveProfile();
      notifyListeners();
    }
  }

  User get user => Init.profile.user;
  set user(User user) {
    Init.profile.user = user;
    Init.saveProfile();
  }
}

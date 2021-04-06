import 'package:flutter/material.dart';
import 'package:mybooks/utils/init.dart';

class MyLocaleModel extends ChangeNotifier {
  set locale(String locale) {
    if (locale != Init.profile.locale) {
      Init.profile.locale = locale;
      Init.saveProfile();
      notifyListeners();
    }
  }

  String get locale => Init.profile.locale;
}

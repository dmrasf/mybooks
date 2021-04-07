import 'package:flutter/material.dart';
import 'package:mybooks/utils/init.dart';

class MyLocaleModel extends ChangeNotifier {
  set locale(String? locale) {
    if (locale != Init.profile.locale) {
      Init.profile.locale = locale;
      Init.saveProfile();
      notifyListeners();
    }
  }

  Locale? getLocale() {
    if (Init.profile.locale != null) {
      List<String> t = Init.profile.locale!.split("_");
      return Locale(t[0], t[1]);
    }
    return null;
  }

  String? get locale => Init.profile.locale;
}

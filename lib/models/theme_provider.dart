import 'package:flutter/material.dart';
import 'package:mybooks/utils/init.dart';

class MyThemeModel extends ChangeNotifier {
  set isLightTheme(bool? isLightTheme) {
    if (isLightTheme != Init.profile.theme) {
      Init.profile.theme = isLightTheme;
      Init.saveProfile();
      notifyListeners();
    }
  }

  bool? get isLightTheme => Init.profile.theme;
}

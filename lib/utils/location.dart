import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class MBLocalizations {
  final Locale _locale;

  MBLocalizations(this._locale);

  static MBLocalizations of(BuildContext context) {
    return Localizations.of<MBLocalizations>(context, MBLocalizations)!;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'My books',
      'login': 'SIGN IN',
      'profile': 'Profile',
    },
    'zh': {
      'title': '我的书籍',
      'login': '登录',
      'profile': '资料',
    },
  };

  String get title {
    return _localizedValues[_locale.languageCode]!['title']!;
  }

  String get login {
    return _localizedValues[_locale.languageCode]!['login']!;
  }

  String get profile {
    return _localizedValues[_locale.languageCode]!['profile']!;
  }
}

class MBLocalizationsDelegate extends LocalizationsDelegate<MBLocalizations> {
  const MBLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['zh', 'en'].contains(locale.languageCode);

  @override
  Future<MBLocalizations> load(Locale locale) {
    return new SynchronousFuture<MBLocalizations>(new MBLocalizations(locale));
  }

  @override
  bool shouldReload(MBLocalizationsDelegate old) => false;
}

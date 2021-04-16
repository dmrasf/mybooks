import 'package:mybooks/models/profile.dart';
import 'package:mybooks/models/secret.dart';
import 'package:mybooks/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Init {
  static late Profile profile;
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    String? _profile = _preferences.getString('profile');
    if (_profile != null)
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    else
      profile = Profile(user: User(), secret: Secret(), login: false);
  }

  static saveProfile() => _preferences.setString(
        'profile',
        jsonEncode(profile.toJson()),
      );
}

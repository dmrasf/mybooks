import 'package:mybooks/models/profile.dart';
import 'package:mybooks/models/secret.dart';
import 'package:mybooks/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mybooks/utils/database.dart';

class Init {
  static late Profile profile;
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    String? _profile = _preferences.getString('profile');
    await DataBaseUtil.initDataBase();
    if (_profile != null)
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
        await DataBaseUtil.initUserTable(profile.user.email);
      } catch (e) {
        print(e);
      }
    else
      profile = Profile(
        user: User(),
        secret: Secret(),
        login: false,
        tags: Map<String, bool>(),
      );
  }

  static saveProfile() => _preferences.setString(
        'profile',
        jsonEncode(profile.toJson()),
      );
}

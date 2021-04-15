import 'package:flutter/material.dart';
import 'package:mybooks/utils/init.dart';
import 'package:mybooks/models/user.dart';

class MyUserModel extends ChangeNotifier {
  bool get isLogin => Init.profile.login;
  set isLogin(bool isLogin) {
    if (isLogin != Init.profile.login) {
      Init.profile.login = isLogin;
      if (isLogin == false) Init.profile.user = User();
      Init.saveProfile();
      notifyListeners();
    }
  }

  User get user => Init.profile.user;
  set user(User user) {
    Init.profile.user = user;
    Init.saveProfile();
  }

  String? get email => Init.profile.user.email;
  set email(String? email) {
    Init.profile.user.email = email;
    Init.saveProfile();
  }

  String? get token => Init.profile.user.token;
  set token(String? token) {
    Init.profile.user.token = token;
    Init.saveProfile();
  }

  String? get location => Init.profile.user.location;
  set location(String? location) {
    Init.profile.user.location = location;
    Init.saveProfile();
  }

  String? get name => Init.profile.user.name;
  set name(String? name) {
    Init.profile.user.name = name;
    Init.saveProfile();
  }

  String? get avatarUrl => Init.profile.user.avatarUrl;
  set avatarUrl(String? avatarUrl) {
    Init.profile.user.avatarUrl = avatarUrl;
    Init.saveProfile();
  }

  int get following => Init.profile.user.following;
  set following(int following) {
    Init.profile.user.following = following;
    Init.saveProfile();
  }

  int get followers => Init.profile.user.followers;
  set followers(int followers) {
    Init.profile.user.followers = followers;
    Init.saveProfile();
  }

  String? get description => Init.profile.user.description;
  set description(String? description) {
    Init.profile.user.description = description;
    Init.saveProfile();
  }

  String? get birthday => Init.profile.user.birthday;
  set birthday(String? birthday) {
    Init.profile.user.birthday = birthday;
    Init.saveProfile();
  }

  bool? get gender => Init.profile.user.gender;
  set gender(bool? gender) {
    Init.profile.user.gender = gender;
    Init.saveProfile();
  }
}

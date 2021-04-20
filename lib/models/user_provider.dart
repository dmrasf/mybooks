import 'package:flutter/material.dart';
import 'package:mybooks/models/secret.dart';
import 'package:mybooks/utils/init.dart';
import 'package:mybooks/utils/global.dart';
import 'package:mybooks/models/user.dart';

class MyUserModel extends ChangeNotifier {
  bool get isLogin => Init.profile.login;
  set isLogin(bool isLogin) {
    if (isLogin != Init.profile.login) {
      Init.profile.login = isLogin;
      if (isLogin == false) {
        Init.profile.user = User();
        Init.profile.secret = Secret();
      }
      Init.saveProfile();
      notifyListeners();
    }
  }

  int get crossAxisCount => Init.profile.crossAxisCount;
  set crossAxisCount(int crossAxisCount) {
    Init.profile.crossAxisCount = crossAxisCount;
    Init.saveProfile();
  }

  Map<String, bool> get tags => Init.profile.tags;
  set tag(MapEntry<String, bool> entry) {
    Init.profile.tags[entry.key] = entry.value;
    Init.saveProfile();
  }

  set tags(Map<String, bool> tags) {
    if (tags.isEmpty)
      Init.profile.tags.clear();
    else
      Init.profile.tags = tags;
    Init.saveProfile();
  }

  SortType get sortType => Init.profile.sortType;
  set sortType(SortType sortType) {
    Init.profile.sortType = sortType;
    Init.saveProfile();
  }

  Secret get secret => Init.profile.secret;
  set secret(Secret secret) {
    Init.profile.secret = secret;
    Init.saveProfile();
  }

  int get booksSecret => Init.profile.secret.books;
  set booksSecret(int secret) {
    Init.profile.secret.books = secret;
    Init.saveProfile();
  }

  int get emailSecret => Init.profile.secret.email;
  set emailSecret(int secret) {
    Init.profile.secret.email = secret;
    Init.saveProfile();
  }

  int get locationSecret => Init.profile.secret.location;
  set locationSecret(int secret) {
    Init.profile.secret.location = secret;
    Init.saveProfile();
  }

  int get followingSecret => Init.profile.secret.following;
  set followingSecret(int secret) {
    Init.profile.secret.following = secret;
    Init.saveProfile();
  }

  int get followersSecret => Init.profile.secret.followers;
  set followersSecret(int secret) {
    Init.profile.secret.followers = secret;
    Init.saveProfile();
  }

  int get birthdaySecret => Init.profile.secret.birthday;
  set birthdaySecret(int secret) {
    Init.profile.secret.birthday = secret;
    Init.saveProfile();
  }

  int get genderSecret => Init.profile.secret.gender;
  set genderSecret(int secret) {
    Init.profile.secret.gender = secret;
    Init.saveProfile();
  }

  User get user => Init.profile.user;
  set user(User user) {
    Init.profile.user = user;
    Init.saveProfile();
  }

  int get books => Init.profile.user.books;
  set books(int books) {
    Init.profile.user.books = books;
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

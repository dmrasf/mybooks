import 'package:flutter/material.dart';
import 'package:mybooks/models/secret.dart';
import 'package:mybooks/utils/http_client.dart';
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

  String? get dailyPoetryToken => Init.profile.dailyPoetryToken;
  set dailyPoetryToken(String? token) {
    Init.profile.dailyPoetryToken = token;
    Init.saveProfile();
  }

  int get crossAxisCount => Init.profile.crossAxisCount;
  set crossAxisCount(int crossAxisCount) {
    Init.profile.crossAxisCount = crossAxisCount;
    Init.saveProfile();
  }

  bool get isTagsUnion => Init.profile.isTagsUnion;
  set isTagsUnion(bool isTagsUnion) {
    Init.profile.isTagsUnion = isTagsUnion;
    Init.saveProfile();
  }

  Map<String, bool> get tags => Init.profile.tags;
  set tag(MapEntry<String, bool> entry) {
    Init.profile.tags[entry.key] = entry.value;
    Init.saveProfile();
  }

  set tags(Map<String, bool> tags) {
    Init.profile.tags.clear();
    Init.profile.tags.addAll(tags);
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
  Future<bool> serBooksSecret(int secret) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'books_secret': secret,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.secret.books = secret;
    Init.saveProfile();
    return true;
  }

  int get emailSecret => Init.profile.secret.email;
  Future<bool> setEmailSecret(int secret) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'email_secret': secret,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.secret.email = secret;
    Init.saveProfile();
    return true;
  }

  int get locationSecret => Init.profile.secret.location;
  Future<bool> setLocationSecret(int secret) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'location_secret': secret,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.secret.location = secret;
    Init.saveProfile();
    return true;
  }

  int get followingSecret => Init.profile.secret.following;
  Future<bool> setFollowingSecret(int secret) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'following_secret': secret,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.secret.following = secret;
    Init.saveProfile();
    return true;
  }

  int get followersSecret => Init.profile.secret.followers;
  Future<bool> setFollowersSecret(int secret) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'followers_secret': secret,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.secret.followers = secret;
    Init.saveProfile();
    return true;
  }

  int get birthdaySecret => Init.profile.secret.birthday;
  Future<bool> setBirthdaySecret(int secret) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'birthday_secret': secret,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.secret.birthday = secret;
    Init.saveProfile();
    return true;
  }

  int get genderSecret => Init.profile.secret.gender;
  Future<bool> setGenderSecret(int secret) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'gender_secret': secret,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.secret.gender = secret;
    Init.saveProfile();
    return true;
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
  Future<bool> setLocation(String? location) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'location': location,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.user.location = location;
    Init.saveProfile();
    return true;
  }

  String? get name => Init.profile.user.name;
  Future<bool> setName(String? name) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'nick_name': name,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.user.name = name;
    Init.saveProfile();
    return true;
  }

  String? get avatarUrl => Init.profile.user.avatarUrl;
  set avatarUrl(String? avatarUrl) {
    _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'avatar_url': avatarUrl,
    }).then((value) {
      if (value == null) return;
      if (value == false) return;
      Init.profile.user.avatarUrl = avatarUrl;
      Init.saveProfile();
    });
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
  Future<bool> setDescription(String? description) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'description': description,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.user.description = description;
    Init.saveProfile();
    return true;
  }

  String? get birthday => Init.profile.user.birthday;
  Future<bool> setBirthday(String? birthday) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'birthday': birthday,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.user.birthday = birthday;
    Init.saveProfile();
    return true;
  }

  bool? get gender => Init.profile.user.gender;
  Future<bool> setGender(bool? gender) async {
    bool? value = await _updateToServer(<String, dynamic>{
      'email': Init.profile.user.email!,
      'token': Init.profile.user.token!,
      'gender': gender,
    });
    if (value == null) return false;
    if (value == false) return false;
    Init.profile.user.gender = gender;
    Init.saveProfile();
    return true;
  }

  Future<bool?> _updateToServer(Map<String, dynamic> body) async {
    var updateInfo = await HttpClientUtil.update(body);
    print(updateInfo);
    if (updateInfo == null) {
      return false;
    }
    if (updateInfo.containsKey('detail')) {
      return false;
    }
    return true;
  }
}

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int books;
  String? email;
  String? token;
  String? location;
  String? name;
  String? avatarUrl;
  int following;
  int followers;
  String? description;
  String? birthday;
  bool? gender;
  User({
    this.books = 0,
    this.email,
    this.token,
    this.following = 0,
    this.followers = 0,
    this.avatarUrl,
    this.name,
    this.description,
    this.location,
    this.birthday,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

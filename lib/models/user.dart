import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User(
    this.email,
    this.token,
    this.location,
    this.name,
    this.avatarUrl,
    this.following,
    this.followers,
    this.description,
    this.birthday,
  );

  String email;
  String token;
  String location;
  String name;
  String avatarUrl;
  int following;
  int followers;
  String description;
  String birthday;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

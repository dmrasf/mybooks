import 'package:json_annotation/json_annotation.dart';
import 'package:mybooks/models/user.dart';
import 'package:mybooks/models/secret.dart';
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  User user;
  Secret secret;

  bool login;
  bool? theme;
  String? locale;
  Profile({
    required this.user,
    required this.secret,
    required this.login,
    this.theme,
    this.locale,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

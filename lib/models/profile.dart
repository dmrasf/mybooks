import 'package:json_annotation/json_annotation.dart';
import 'package:mybooks/models/user.dart';
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  User user;
  bool login;
  bool? theme;
  String? locale;
  Profile({
    required this.user,
    required this.login,
    this.theme,
    this.locale,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

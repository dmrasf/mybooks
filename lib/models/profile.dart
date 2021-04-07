import 'package:json_annotation/json_annotation.dart';
import 'package:mybooks/models/user.dart';
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile(this.user, this.login, this.theme, this.locale);

  User user;
  bool login;
  bool theme;
  String? locale;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

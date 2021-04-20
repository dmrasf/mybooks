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
  Map<String, bool> tags;
  int crossAxisCount;
  Profile({
    required this.user,
    required this.secret,
    required this.login,
    this.theme,
    this.tags = const {},
    this.crossAxisCount = 2,
    this.locale,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

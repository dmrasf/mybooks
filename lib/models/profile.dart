import 'package:json_annotation/json_annotation.dart';
import 'package:mybooks/models/user.dart';
import 'package:mybooks/models/secret.dart';
import 'package:mybooks/utils/global.dart';
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  User user;
  Secret secret;

  bool login;
  bool? theme;
  String? locale;
  Map<String, bool> tags;
  bool isTagsUnion;
  int crossAxisCount;
  SortType sortType;
  Profile({
    required this.user,
    required this.secret,
    required this.login,
    this.theme,
    required this.tags,
    this.isTagsUnion = false,
    this.crossAxisCount = 2,
    this.locale,
    this.sortType = SortType.dateOrder,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

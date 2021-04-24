import 'package:json_annotation/json_annotation.dart';
part 'secret.g.dart';

@JsonSerializable(explicitToJson: true)
class Secret {
  int books;
  int email;
  int location;
  int following;
  int followers;
  int birthday;
  int gender;
  Secret({
    this.books = 0,
    this.email = 0,
    this.following = 0,
    this.followers = 0,
    this.location = 0,
    this.birthday = 0,
    this.gender = 0,
  });

  factory Secret.fromJson(Map<String, dynamic> json) => _$SecretFromJson(json);

  Map<String, dynamic> toJson() => _$SecretToJson(this);
}

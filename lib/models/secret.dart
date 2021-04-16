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
    this.books = 4,
    this.email = 4,
    this.following = 4,
    this.followers = 4,
    this.location = 4,
    this.birthday = 4,
    this.gender = 4,
  });

  factory Secret.fromJson(Map<String, dynamic> json) => _$SecretFromJson(json);

  Map<String, dynamic> toJson() => _$SecretToJson(this);
}

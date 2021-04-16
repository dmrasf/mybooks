// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    secret: Secret.fromJson(json['secret'] as Map<String, dynamic>),
    login: json['login'] as bool,
    theme: json['theme'] as bool?,
    locale: json['locale'] as String?,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'secret': instance.secret.toJson(),
      'login': instance.login,
      'theme': instance.theme,
      'locale': instance.locale,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    User.fromJson(json['user'] as Map<String, dynamic>),
    json['login'] as bool,
    json['theme'] as bool?,
    json['locale'] as String?,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'login': instance.login,
      'theme': instance.theme,
      'locale': instance.locale,
    };

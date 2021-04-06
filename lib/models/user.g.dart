// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['email'] as String,
    json['token'] as String,
    json['location'] as String,
    json['name'] as String,
    json['avatarUrl'] as String,
    json['following'] as int,
    json['followers'] as int,
    json['description'] as String,
    json['birthday'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
      'location': instance.location,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'following': instance.following,
      'followers': instance.followers,
      'description': instance.description,
      'birthday': instance.birthday,
    };

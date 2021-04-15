// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String?,
    token: json['token'] as String?,
    following: json['following'] as int,
    followers: json['followers'] as int,
    avatarUrl: json['avatarUrl'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    location: json['location'] as String?,
    birthday: json['birthday'] as String?,
    gender: json['gender'] as bool?,
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
      'gender': instance.gender,
    };

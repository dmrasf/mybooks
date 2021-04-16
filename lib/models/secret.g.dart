// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Secret _$SecretFromJson(Map<String, dynamic> json) {
  return Secret(
    books: json['books'] as int,
    email: json['email'] as int,
    following: json['following'] as int,
    followers: json['followers'] as int,
    location: json['location'] as int,
    birthday: json['birthday'] as int,
    gender: json['gender'] as int,
  );
}

Map<String, dynamic> _$SecretToJson(Secret instance) => <String, dynamic>{
      'books': instance.books,
      'email': instance.email,
      'location': instance.location,
      'following': instance.following,
      'followers': instance.followers,
      'birthday': instance.birthday,
      'gender': instance.gender,
    };

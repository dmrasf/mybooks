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
    tags: Map<String, bool>.from(json['tags'] as Map),
    isTagsUnion: json['isTagsUnion'] as bool,
    crossAxisCount: json['crossAxisCount'] as int,
    locale: json['locale'] as String?,
    sortType: _$enumDecode(_$SortTypeEnumMap, json['sortType']),
    dailyPoetryToken: json['dailyPoetryToken'] as String?,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'secret': instance.secret.toJson(),
      'login': instance.login,
      'theme': instance.theme,
      'locale': instance.locale,
      'tags': instance.tags,
      'isTagsUnion': instance.isTagsUnion,
      'crossAxisCount': instance.crossAxisCount,
      'sortType': _$SortTypeEnumMap[instance.sortType],
      'dailyPoetryToken': instance.dailyPoetryToken,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$SortTypeEnumMap = {
  SortType.letterOrder: 'letterOrder',
  SortType.inletterOrder: 'inletterOrder',
  SortType.dateOrder: 'dateOrder',
  SortType.indateOrder: 'indateOrder',
};

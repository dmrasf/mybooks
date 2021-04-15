// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    isbn: json['isbn'] as String,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'isbn': instance.isbn,
      'name': instance.name,
      'price': instance.price,
    };

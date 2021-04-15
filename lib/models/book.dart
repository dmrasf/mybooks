import 'package:json_annotation/json_annotation.dart';
part 'book.g.dart';

@JsonSerializable(explicitToJson: true)
class Book {
  String isbn;
  String name;
  double price;
  Book({
    required this.isbn,
    required this.name,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

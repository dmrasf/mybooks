import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';

class BooksShow extends StatefulWidget {
  final List<UserBook> books;
  BooksShow({Key? key, required this.books}) : super(key: key);
  @override
  _BooksShowState createState() => _BooksShowState();
}

class _BooksShowState extends State<BooksShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Column(
        children: List.generate(
          widget.books.length,
          (index) => Text(
              widget.books[index].isbn + ' ' + widget.books[index].touchdate),
        ),
      ),
    );
  }
}

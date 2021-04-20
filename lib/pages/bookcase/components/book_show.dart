import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';

class BookShow extends StatefulWidget {
  final UserBook userBook;
  final Book book;
  final String isbn;
  BookShow({
    Key? key,
    required this.userBook,
    required this.isbn,
    required this.book,
  }) : super(key: key);
  @override
  _BookShowState createState() => _BookShowState();
}

class _BookShowState extends State<BookShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForSettingPage(context, title: widget.book.title),
      body: Container(
        width: 300,
        child: Hero(
          tag: widget.isbn,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: widget.book.cover == null
                    ? null
                    : DecorationImage(
                        image: MemoryImage(widget.book.cover!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

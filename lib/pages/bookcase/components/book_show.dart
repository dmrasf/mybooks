import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';

class BookShow extends StatefulWidget {
  final Book book;
  final String isbn;
  final VoidCallback? update;
  BookShow({Key? key, required this.isbn, required this.book, this.update})
      : super(key: key);
  @override
  _BookShowState createState() => _BookShowState();
}

class _BookShowState extends State<BookShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForSettingPage(context, title: widget.book.title),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  width: MediaQuery.of(context).size.width * 0.4,
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
                SizedBox(width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

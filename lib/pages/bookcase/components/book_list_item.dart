import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/database.dart';

class BookShowListItem extends StatefulWidget {
  final String isbn;
  BookShowListItem({Key? key, required this.isbn}) : super(key: key);
  @override
  _BookShowListItemState createState() => _BookShowListItemState();
}

class _BookShowListItemState extends State<BookShowListItem> {
  Book? _book;
  UserBook? _userBooks;

  @override
  void initState() {
    DataBaseUtil.getBook(isbn: widget.isbn).then(
      (value) => setState(() => _book = value),
    );
    DataBaseUtil.queryUserBook(isbn: widget.isbn).then((value) {
      print(value);
      if (value != null) setState(() => _userBooks = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: _book?.cover == null
                    ? null
                    : DecorationImage(
                        image: MemoryImage(_book!.cover!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: _book?.title == null
                        ? Container()
                        : Text(
                            _book!.title!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .buttonColor
                                  .withOpacity(0.8),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        _getTouchDate(),
                        style: TextStyle(
                          color: Theme.of(context).buttonColor.withOpacity(0.2),
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTouchDate() {
    if (_userBooks == null) return ' ';
    String touchdate = _userBooks!.touchdate;
    DateTime pd = DateTime.parse(touchdate);
    DateTime cd = DateTime.now();
    int days = cd.difference(pd).inDays;
    if (days == 0) return '今天';
    int months = days % 30;
    if (months == 0) return '$days天前';
    int years = days % 365;
    if (years == 0) return '$months月前';
    return '$years年前';
  }
}

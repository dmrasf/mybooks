import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/bookcase/components/book_show.dart';

class BookShowListItem extends StatefulWidget {
  final String isbn;
  BookShowListItem({Key? key, required this.isbn}) : super(key: key);
  @override
  _BookShowListItemState createState() => _BookShowListItemState();
}

class _BookShowListItemState extends State<BookShowListItem> {
  Book? _book;
  UserBook? _userBook;

  @override
  void initState() {
    DataBaseUtil.getBook(isbn: widget.isbn).then(
      (value) => setState(() => _book = value),
    );
    DataBaseUtil.queryUserBook(isbn: widget.isbn).then((value) {
      if (value != null) setState(() => _userBook = value);
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
          GestureDetector(
            onTap: () {
              print(widget.isbn);
              ChangePage.fadeChangePage(
                context,
                BookShow(userBook: _userBook!, isbn: widget.isbn, book: _book!),
              );
            },
            onLongPress: () {},
            child: Hero(
              tag: widget.isbn,
              child: AspectRatio(
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
    if (_userBook == null) return ' ';
    String touchdate = _userBook!.touchdate;
    DateTime pd = DateTime.parse(touchdate);
    DateTime cd = DateTime.now();
    int years = cd.year - pd.year;
    if (years != 0) return '$years 年前';
    int months = cd.month - pd.month;
    if (months != 0) return '$months 月前';
    int days = cd.day - pd.day;
    if (days != 0) return '$days 天前';
    return '今天';
  }
}

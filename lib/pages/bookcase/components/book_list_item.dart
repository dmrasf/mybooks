import 'package:flutter/material.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/bookcase/components/book_show.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';

class BookShowListItem extends StatefulWidget {
  final String isbn;
  final int crossAxisCount;
  BookShowListItem({Key? key, required this.isbn, required this.crossAxisCount})
      : super(key: key);
  @override
  _BookShowListItemState createState() => _BookShowListItemState();
}

class _BookShowListItemState extends State<BookShowListItem> {
  Book? _book;

  @override
  void initState() {
    DataBaseUtil.getBook(isbn: widget.isbn).then(
      (value) => setState(() => _book = value),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size widgetSize = Size(
      MediaQuery.of(context).size.width / widget.crossAxisCount * 2.25 / 3.25,
      MediaQuery.of(context).size.width / widget.crossAxisCount / 3.25 * 1.5,
    );
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(widgetSize.width * 0.05),
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              print(widget.isbn);
              ChangePage.fadeChangePage(
                context,
                BookShow(
                  isbn: widget.isbn,
                  book: _book!,
                  update: () => setState(() {}),
                ),
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
              padding: EdgeInsets.only(
                left: widgetSize.width * 0.05,
                top: widgetSize.width * 0.05,
              ),
              child: Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: widgetSize.width * 0.5,
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: _book?.title == null
                            ? Container()
                            : Text(
                                _book!.title!,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .buttonColor
                                      .withOpacity(0.8),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: widgetSize.height * 0.3,
                    child: Container(
                      width: widgetSize.width * 0.5,
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _book?.author == null ? '作者' : '作者：' + _book!.author!,
                          style: TextStyle(
                            color:
                                Theme.of(context).buttonColor.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: widgetSize.width * 0.5,
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _book?.rate == null
                              ? '暂无评分'
                              : _book!.rate!.toStringAsFixed(0),
                          style: TextStyle(
                            color:
                                Theme.of(context).buttonColor.withOpacity(0.4),
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: widgetSize.width * 0.2,
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _getTouchDate(
                            context
                                .read<MyUserBooksModel>()
                                .userBooks[widget.isbn]!,
                          ),
                          style: TextStyle(
                            color:
                                Theme.of(context).buttonColor.withOpacity(0.2),
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                          ),
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

  String _getTouchDate(UserBook userBook) {
    String touchdate = userBook.touchdate;
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

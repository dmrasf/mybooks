import 'package:flutter/material.dart';
import 'package:mybooks/models/booksShowStatus_provider.dart';
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
    late bool _isToggle;
    final myBooksShowStatusProvider =
        Provider.of<MyBooksShowStatusModel>(context);
    if (myBooksShowStatusProvider.selectedBooks.contains(widget.isbn))
      _isToggle = true;
    else
      _isToggle = false;
    return Consumer2<MyBooksShowStatusModel, MyUserBooksModel>(
      builder: (context, myBooksShowStatus, userBooksProvider, child) =>
          Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(widgetSize.width * 0.05),
        color: Theme.of(context).primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onLongPress: () {
                    myBooksShowStatus.isSelected = true;
                    myBooksShowStatus.selectedBooks.add(widget.isbn);
                  },
                  onDoubleTap: myBooksShowStatus.isSelected
                      ? null
                      : () {
                          int? currentRead =
                              userBooksProvider.userBooks[widget.isbn]!.read;
                          int? newRead;
                          switch (currentRead) {
                            case null:
                              newRead = 1;
                              break;
                            case 1:
                              newRead = 0;
                              break;
                            case 0:
                              newRead = null;
                              break;
                            default:
                              newRead = null;
                              break;
                          }
                          userBooksProvider.changeUserBookRead(
                              widget.isbn, newRead);
                          setState(() {});
                        },
                  onTap: myBooksShowStatus.isSelected
                      ? () {
                          myBooksShowStatus.selectedBook(
                              widget.isbn, !_isToggle);
                          setState(() {});
                        }
                      : () => ChangePage.fadeChangePage(
                            context,
                            BookShow(
                              isbn: widget.isbn,
                              book: _book!,
                              update: () => setState(() {}),
                            ),
                          ),
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: widgetSize.width * 0.2,
                    alignment: Alignment.center,
                    color: Theme.of(context).hintColor,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: userBooksProvider.userBooks[widget.isbn]!.read ==
                              null
                          ? null
                          : Text(
                              userBooksProvider.userBooks[widget.isbn]!.read ==
                                      1
                                  ? '??????'
                                  : '??????',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
                myBooksShowStatus.isSelected
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: widgetSize.height * 0.2,
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              _isToggle
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_outlined,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
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
                            _book?.author == null
                                ? '??????'
                                : '?????????' + _book!.author!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .buttonColor
                                  .withOpacity(0.6),
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
                        width: widgetSize.width * 0.2,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _book?.rate == null ? '????????????' : _book!.rate!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .buttonColor
                                  .withOpacity(0.4),
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
                            _getTouchDate(context
                                .read<MyUserBooksModel>()
                                .userBooks[widget.isbn]!),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .buttonColor
                                  .withOpacity(0.4),
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
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
      ),
    );
  }

  String _getTouchDate(UserBook userBook) {
    String touchdate = userBook.touchdate;
    DateTime pd = DateTime.parse(touchdate);
    DateTime cd = DateTime.now();
    int years = cd.year - pd.year;
    if (years != 0) return '$years ??????';
    int months = cd.month - pd.month;
    if (months != 0) return '$months ??????';
    int days = cd.day - pd.day;
    if (days != 0) return '$days ??????';
    return '??????';
  }
}

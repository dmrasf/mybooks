import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/database.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/bookcase/components/bookcase_title_card.dart';

class BookShowListItem extends StatefulWidget {
  final String isbn;
  BookShowListItem({Key? key, required this.isbn}) : super(key: key);
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
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
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
          SizedBox(width: 20),
          Container(
            width: 40,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //FittedBox(
                //fit: BoxFit.contain,
                //child:
                //_book?.title == null ? Container() : Text(_book!.title!),
                //),
                //FittedBox(
                //fit: BoxFit.contain,
                //child: _book?.author == null
                //? Container()
                //: Text(_book!.author!),
                //),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

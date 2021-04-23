import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/database.dart';

class RecordTitleCard extends StatefulWidget {
  final Map<String, Book> allUserBooks;
  RecordTitleCard({required this.allUserBooks});
  @override
  _RecordTitleCardState createState() => _RecordTitleCardState();
}

class _RecordTitleCardState extends State<RecordTitleCard> {
  double _totalPrice = 0.0;
  int _totalPages = 0;

  @override
  void didUpdateWidget(covariant RecordTitleCard oldWidget) {
    _getTotalPagesPrice();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, right: 20, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 618,
            child: Container(),
          ),
          Expanded(
            flex: 382,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '总价格：' + _totalPrice.toStringAsFixed(2),
                      style: _getTextStyle(),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '总页码：' + _totalPages.toString(),
                      style: _getTextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  TextStyle _getTextStyle() {
    return GoogleFonts.jua(
      textStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).buttonColor.withOpacity(0.8),
      ),
    );
  }

  /// 获取所有书籍的总价和页码
  void _getTotalPagesPrice() async {
    _totalPages = 0;
    _totalPrice = 0.0;
    double tmpTotalPrice = 0.0;
    int tmpTotalPages = 0;
    for (Book book in widget.allUserBooks.values) {
      if (book.pages != null) {
        final matchPages = RegExp(r"[0-9]+").firstMatch(book.pages!);
        if (matchPages == null) continue;
        if (matchPages.group(0) == null) continue;
        try {
          tmpTotalPages = int.parse(matchPages.group(0)!);
        } catch (e) {
          print('record=>components=>title_card.dart\n' + e.toString());
          continue;
        }
        _totalPages += tmpTotalPages;
      }
    }
    for (Book book in widget.allUserBooks.values) {
      if (book.price != null) {
        final matchPrice = RegExp(r"[0-9]+[\.]?[0-9]*").firstMatch(book.price!);
        if (matchPrice == null) continue;
        if (matchPrice.group(0) == null) continue;
        try {
          tmpTotalPrice = double.parse(matchPrice.group(0)!);
        } catch (e) {
          print('record=>components=>title_card.dart\n' + e.toString());
          continue;
        }
        _totalPrice += tmpTotalPrice;
      }
    }
    setState(() {});
  }
}

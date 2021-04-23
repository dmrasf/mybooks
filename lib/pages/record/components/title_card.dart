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
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, right: 20),
      alignment: Alignment.bottomRight,
      child: Text(
        _totalPrice.toStringAsFixed(2) + ' ' + _totalPages.toString(),
        style: GoogleFonts.jua(
          textStyle: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).buttonColor.withOpacity(0.7),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  /// 获取所有书籍的总价和页码
  void _getTotalPagesPrice() async {
    _totalPages = 0;
    _totalPrice = 0.0;
    double tmpTotalPrice = 0.0;
    for (Book book in widget.allUserBooks.values) {
      if (book.pages != null) _totalPages += book.pages!;
      if (book.price == null) continue;
      final match = RegExp(r"[0-9]+[\.]?[0-9]*").firstMatch(book.price!);
      if (match == null) return;
      if (match.group(0) == null) return;
      try {
        tmpTotalPrice = double.parse(match.group(0)!);
      } catch (e) {
        print('record=>components=>title_card.dart\n' + e.toString());
        continue;
      }
      _totalPrice += tmpTotalPrice;
    }
    setState(() {});
  }
}

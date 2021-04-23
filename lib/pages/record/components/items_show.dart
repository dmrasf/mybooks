import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/record/components/title_card.dart';
import 'package:mybooks/pages/record/components/line_show_add_history.dart';

class RecordItemsShow extends StatefulWidget {
  final List<String> userBooks;
  RecordItemsShow({required this.userBooks});
  @override
  _RecordItemsShowState createState() => _RecordItemsShowState();
}

class _RecordItemsShowState extends State<RecordItemsShow> {
  Map<String, Book> _allUserBooks = {};

  @override
  void initState() {
    _getAllUserBooks();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RecordItemsShow oldWidget) {
    _getAllUserBooks();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 1),
      child: Column(
        children: [
          RecordTitleCard(allUserBooks: _allUserBooks),
          SizedBox(height: 10),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    LineShowAddHistory(allUserBooks: _allUserBooks),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getAllUserBooks() async {
    _allUserBooks.clear();
    for (int i = 0; i < widget.userBooks.length; i++) {
      Book? book = await DataBaseUtil.getBook(isbn: widget.userBooks[i]);
      if (book == null) continue;
      _allUserBooks[widget.userBooks[i]] = book;
    }
    setState(() {});
  }
}

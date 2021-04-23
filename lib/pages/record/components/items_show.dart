import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/record/components/title_card.dart';
import 'package:mybooks/pages/record/components/line_show_add_history.dart';

import 'package:fl_chart/fl_chart.dart';

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
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 10),
                    LineShowAddHistory(allUserBooks: _allUserBooks),
                    //PieChartSample2(),
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

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 20, top: 20, bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            colors: [Color(0xff482058), Colors.white30],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData>? showingSections() {
    return List.generate(4, (i) {
      final double fontSize = 16;
      final double radius = 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/database.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';

class LineShowAddHistory extends StatefulWidget {
  final Map<String, Book> allUserBooks;
  LineShowAddHistory({required this.allUserBooks});
  @override
  State<StatefulWidget> createState() => LineShowAddHistoryState();
}

class LineShowAddHistoryState extends State<LineShowAddHistory> {
  List<DateTime> _historyDate = [];
  Map<DateTime, Set<String>> _historyBooks = {};

  @override
  void didUpdateWidget(covariant LineShowAddHistory oldWidget) {
    _getHistoryData();
    super.didUpdateWidget(oldWidget);
  }

  void _getHistoryData() async {
    Set<DateTime> tmpDate = Set();
    context.read<MyUserBooksModel>().userBooks.values.forEach((userBook) {
      DateTime tmp = DateTime.parse(userBook.touchdate);
      if (_historyBooks[DateTime(tmp.year, tmp.month, tmp.day)] == null)
        _historyBooks[DateTime(tmp.year, tmp.month, tmp.day)] = Set();
      _historyBooks[DateTime(tmp.year, tmp.month, tmp.day)]!.add(userBook.isbn);
      tmpDate.add(DateTime(tmp.year, tmp.month, tmp.day));
    });
    _historyDate.addAll(tmpDate);
    _historyDate.sort((a, b) => a.compareTo(b));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 20, top: 20, bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            colors: [Color(0x4fac2d4c), Color(0x4d96496c)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'HISTORY',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: LineChart(
                    lineData(),
                    swapAnimationDuration: const Duration(milliseconds: 100),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData lineData() {
    final userBooksModel = Provider.of<MyUserBooksModel>(context);
    int historyDays = _historyDate[_historyDate.length - 1]
        .difference(_historyDate[0])
        .inDays;
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => _barStyle(),
          interval: 1,
          getTitles: (value) {
            DateTime tmp = _historyDate[0].add(Duration(days: value.toInt()));
            return tmp.month.toString() + '-' + tmp.day.toString();
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => _barStyle(),
          interval: userBooksModel.userBooks.length > 10
              ? userBooksModel.userBooks.length / 10
              : 1,
          getTitles: (value) => value.toInt().toString(),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 1),
          left: BorderSide(color: Colors.black, width: 1),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      minX: -1,
      maxX: historyDays + 1,
      minY: 0,
      maxY: userBooksModel.userBooks.length + 1,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: List.generate(
        _historyDate.length + 2,
        (i) {
          if (i == 0) {
            return FlSpot(
              -1,
              0,
            );
          }
          if (i == _historyDate.length + 1)
            return FlSpot(
              (_historyDate[0]
                          .difference(_historyDate[_historyDate.length - 1])
                          .inDays +
                      1)
                  .toDouble(),
              0,
            );
          return FlSpot(
            (_historyDate[0].difference(_historyDate[i - 1]).inDays).toDouble(),
            _historyBooks[_historyDate[i - 1]]!.length.toDouble(),
          );
        },
      ),
      isCurved: true,
      colors: [Colors.black],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
    return [lineChartBarData];
  }

  TextStyle _barStyle() {
    return GoogleFonts.jua(
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 10,
      ),
    );
  }
}

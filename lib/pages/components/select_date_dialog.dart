import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/components/scroll_select_item.dart';
import 'package:mybooks/pages/components/slide_show_dialog.dart';

class DateSelectDialog extends StatefulWidget {
  final String content;
  DateSelectDialog({
    Key? key,
    required this.content,
  }) : super(key: key);
  @override
  _DateSelectDialogState createState() => _DateSelectDialogState();
}

class _DateSelectDialogState extends State<DateSelectDialog> {
  final int _allYear = 30;
  int _year = 1990;
  int _month = 1;
  int _day = 1;
  int days = 31;

  @override
  Widget build(BuildContext context) {
    return SlideShowDialog(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.only(top: 25, bottom: 20),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.content,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 25),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ScrollSelectItems(
                          items: List.generate(
                            _allYear,
                            (index) =>
                                DateTime.now().year - _allYear - 1 + index,
                          ),
                          listener: (value) => setState(() {
                            _year = DateTime.now().year -
                                _allYear -
                                1 +
                                (value as int);
                            days = DateTime(_year, _month + 1, 0).day;
                            if (_day > days) _day = days;
                          }),
                        ),
                        ScrollSelectItems(
                          items: List.generate(12, (index) => index + 1),
                          listener: (value) => setState(() {
                            _month = value + 1;
                            days = DateTime(_year, _month + 1, 0).day;
                            if (_day > days) _day = days;
                          }),
                        ),
                        ScrollSelectItems(
                          items: List.generate(days, (index) => index + 1),
                          listener: (value) => _day = value + 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text("清除"),
                        onPressed: () => Navigator.of(context).pop('clear'),
                        style: _getButtonStyle(),
                      ),
                      TextButton(
                        child: Text("确认"),
                        onPressed: () {
                          print(_year);
                          String result = '$_year-';
                          result += _month >= 10 ? '$_month-' : '0$_month-';
                          result += _day >= 10 ? '$_day' : '0$_day';
                          print(result);
                          Navigator.of(context).pop(result);
                        },
                        style: _getButtonStyle(),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size.zero),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.exo(textStyle: TextStyle(fontWeight: FontWeight.bold)),
      ),
      foregroundColor: MaterialStateProperty.all(Theme.of(context).hintColor),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}

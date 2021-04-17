import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/components/scroll_select_item.dart';
import 'package:mybooks/utils/city.dart';

class CitySelectDialog extends StatefulWidget {
  final String content;
  CitySelectDialog({
    Key? key,
    required this.content,
  }) : super(key: key);
  @override
  _CitySelectDialogState createState() => _CitySelectDialogState();
}

class _CitySelectDialogState extends State<CitySelectDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Map<String, String> provinces = provincesData;
  Map<String, dynamic> cities = citiesData['110000'];
  Map<String, dynamic> areaes = citiesData['110100'];

  String _currentProvince = '北京市';
  String _currentCity = '北京城区';
  String _currentArea = '东城区';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(
        begin: Offset(0, 1),
        end: Offset(0, 0),
      ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller!),
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
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ScrollSelectItems(
                          items: List.generate(
                            provinces.length,
                            (index) =>
                                provinces[provinces.keys.toList()[index]],
                          ),
                          listener: (index) {
                            setState(() {
                              cities =
                                  citiesData[provinces.keys.toList()[index]];
                              areaes = citiesData[cities.keys.toList()[0]];
                            });
                            _currentProvince =
                                provinces[provinces.keys.toList()[index]]!;
                            _currentCity =
                                cities[cities.keys.toList()[0]]['name']!;
                            _currentArea =
                                areaes[areaes.keys.toList()[0]]['name']!;
                          },
                        ),
                        ScrollSelectItems(
                          items: List.generate(
                            cities.length,
                            (index) =>
                                cities[cities.keys.toList()[index]]['name'],
                          ),
                          listener: (index) {
                            setState(() {
                              areaes = citiesData[cities.keys.toList()[
                                  index > cities.length - 1
                                      ? cities.length - 1
                                      : index]];
                            });
                            _currentCity = cities[cities.keys.toList()[
                                index > cities.length - 1
                                    ? cities.length - 1
                                    : index]]['name']!;
                            _currentArea =
                                areaes[areaes.keys.toList()[0]]['name']!;
                          },
                        ),
                        ScrollSelectItems(
                          items: List.generate(
                            areaes.length,
                            (index) =>
                                areaes[areaes.keys.toList()[index]]['name'],
                          ),
                          listener: (index) {
                            _currentArea = areaes[areaes.keys.toList()[
                                index > areaes.length - 1
                                    ? areaes.length - 1
                                    : index]]['name']!;
                          },
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
                          Navigator.of(context).pop(
                              '$_currentProvince $_currentCity $_currentArea');
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

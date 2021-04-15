import 'package:flutter/material.dart';

class MyTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff323232),
    backgroundColor: Color(0xff2e2e2e),
    buttonColor: Color(0xffffffff),
  );
  static final lightTheme = ThemeData(
    primaryColor: Color(0xffffffff),
    backgroundColor: Color(0xfffafafa),
    buttonColor: Color(0xff000000),
  );
}

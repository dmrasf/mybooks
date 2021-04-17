import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff323232),
    backgroundColor: Color(0xff2e2e2e),
    buttonColor: Color(0xffcfcfcf),
    dialogBackgroundColor: Color(0xff363636),
    hintColor: Colors.orange.shade700,
    errorColor: Colors.red,
    textTheme: TextTheme(
      headline1: GoogleFonts.jua(
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Color(0xffcfcfcf),
        ),
      ),
      headline2: GoogleFonts.jua(
        textStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 13,
          color: Color(0xffcfcfcf),
        ),
      ),
      headline3: GoogleFonts.jua(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color(0xffcfcfcf).withOpacity(0.4),
        ),
      ),
    ),
  );
  static final lightTheme = ThemeData(
    primaryColor: Color(0xffffffff),
    backgroundColor: Color(0xfffafafa),
    buttonColor: Color(0xff404040),
    dialogBackgroundColor: Color(0xfff7f7f7),
    hintColor: Colors.orange.shade700,
    errorColor: Colors.red,
    textTheme: TextTheme(
      headline1: GoogleFonts.jua(
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Color(0xff404040),
        ),
      ),
      headline2: GoogleFonts.jua(
        textStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 13,
          color: Color(0xff404040),
        ),
      ),
      headline3: GoogleFonts.jua(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color(0xff4040400).withOpacity(0.4),
        ),
      ),
    ),
  );
}

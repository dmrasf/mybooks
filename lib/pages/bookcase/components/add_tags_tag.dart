import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'dart:math';

class AddTagsTag extends StatelessWidget {
  final VoidCallback? clear;
  final String tagName;
  AddTagsTag({this.clear, required this.tagName});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 70, minWidth: 20),
      height: 30,
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      //color: Theme.of(context).hintColor,
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          tagName,
          style: GoogleFonts.jua(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color((Random(Timeline.now).nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
            Color((Random(Timeline.now).nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
    );
  }
}

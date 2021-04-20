import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagsChoosePage extends StatefulWidget {
  @override
  _TagsChoosePageState createState() => _TagsChoosePageState();
}

class _TagsChoosePageState extends State<TagsChoosePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 50),
      color: Theme.of(context).backgroundColor,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.topLeft,
      child: Hero(
        tag: '#',
        child: Text(
          '# 标签 #',
          style: GoogleFonts.jua(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 50,
              color: Theme.of(context).buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

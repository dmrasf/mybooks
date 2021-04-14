import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutmeInfo extends StatefulWidget {
  @override
  _AboutmeInfoState createState() => _AboutmeInfoState();
}

class _AboutmeInfoState extends State<AboutmeInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.black.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AboutmeInfItem(title: '书籍数', hint: '0'),
          AboutmeInfItem(title: '关注', hint: '0'),
          AboutmeInfItem(title: '被关注', hint: '0'),
        ],
      ),
    );
  }
}

class AboutmeInfItem extends StatelessWidget {
  final String title;
  final String hint;
  final GestureTapCallback? onPressed;
  AboutmeInfItem({
    Key? key,
    required this.title,
    required this.hint,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: GoogleFonts.jua(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.exo(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

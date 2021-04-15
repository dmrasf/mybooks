import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class AboutmeImgName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            width: 100,
            height: 100,
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
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://avatars.githubusercontent.com/u/51014758?v=4',
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          Text(
            'dmrasf',
            style: GoogleFonts.ntr(
              textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

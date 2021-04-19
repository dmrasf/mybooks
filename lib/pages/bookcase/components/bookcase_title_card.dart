import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookcaseTitleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      //margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 30,
            child: Text(
              '你的书架',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Positioned(
            right: 6,
            bottom: 10,
            width: MediaQuery.of(context).size.width * 0.25,
            height: 50,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '花有重开日，\n人无再少年。',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff7080e7), Color(0xff90eaff)],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),

        //borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}

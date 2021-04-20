import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookcaseTitleCard extends StatelessWidget {
  final int? booksNum;
  BookcaseTitleCard({this.booksNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 60,
            child: Text(
              booksNum == null ? '0' : booksNum!.toString(),
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).buttonColor.withOpacity(0.4),
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
                    color: Theme.of(context).buttonColor.withOpacity(0.3),
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
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        //gradient: LinearGradient(
        //colors: [Color(0xff7080e7), Color(0xff90eaff)],
        //begin: Alignment.topCenter,
        //end: Alignment.bottomRight,
        //),

        //borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}

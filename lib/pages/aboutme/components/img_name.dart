import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class AboutmeImgName extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final String? description;
  AboutmeImgName({
    Key? key,
    this.avatarUrl,
    this.name,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
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
              //'https://avatars.githubusercontent.com/u/51014758?v=4',
              image: avatarUrl == null
                  ? null
                  : DecorationImage(image: NetworkImage(avatarUrl!)),
            ),
          ),
          SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name == null ? "What's your name?" : name!,
                style: GoogleFonts.ntr(
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).buttonColor,
                  ),
                ),
              ),
              Text(
                description == null ? 'Hi ~  o(*￣▽￣*)ブ' : description!,
                style: GoogleFonts.ntr(
                  textStyle: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).buttonColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

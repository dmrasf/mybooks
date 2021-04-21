import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:developer';
import 'dart:math';

class AboutmeImgName extends StatefulWidget {
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
  _AboutmeImgNameState createState() => _AboutmeImgNameState();
}

class _AboutmeImgNameState extends State<AboutmeImgName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3080e7), Color(0xff00eaff)],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.avatarUrl == null ? '' : widget.avatarUrl!,
            imageBuilder: (context, imageProvider) => Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => _getAvatar(),
            errorWidget: (context, url, error) => _getAvatar(),
          ),
          SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name == null ? "What's your name?" : widget.name!,
                style: GoogleFonts.ntr(
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.4,
                ),
                child: Text(
                  widget.description == null
                      ? 'Hi ~  o(*￣▽￣*)ブ'
                      : widget.description!,
                  style: GoogleFonts.ntr(
                    textStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getAvatar() {
    return AnimatedContainer(
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
      ),
    );
  }
}

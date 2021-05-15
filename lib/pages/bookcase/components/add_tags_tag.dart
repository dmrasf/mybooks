import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'dart:math';

class AddTagsTag extends StatefulWidget {
  final VoidCallback? clear;
  final String tagName;
  final bool isToggle;
  final void Function(bool) listener;
  AddTagsTag({
    this.clear,
    required this.isToggle,
    required this.tagName,
    required this.listener,
  });
  @override
  _AddTagsTagState createState() => _AddTagsTagState();
}

class _AddTagsTagState extends State<AddTagsTag> {
  late bool _isToggle;

  @override
  void initState() {
    _isToggle = widget.isToggle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isToggle = !_isToggle;
              widget.listener(_isToggle);
            });
          },
          child: Container(
            width: widget.tagName.length * 4 + 30,
            height: 30,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            margin: EdgeInsets.only(right: widget.clear == null ? 0 : 20),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                widget.tagName,
                style: GoogleFonts.jua(
                  textStyle: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: _isToggle
                        ? Colors.black54
                        : Theme.of(context).buttonColor,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: _isToggle == true
                  ? LinearGradient(
                      colors: [
                        Color((Random(Timeline.now).nextDouble() * 0xFFFFFF)
                                .toInt())
                            .withOpacity(1.0),
                        Color((Random(Timeline.now).nextDouble() * 0xFFFFFF)
                                .toInt())
                            .withOpacity(1.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    )
                  : null,
              borderRadius: BorderRadius.all(Radius.circular(9)),
              border: Border.all(
                color: _isToggle
                    ? Colors.transparent
                    : Theme.of(context).buttonColor,
                width: 1,
              ),
            ),
          ),
        ),
        widget.clear == null
            ? SizedBox()
            : Positioned(
                right: -3,
                child: GestureDetector(
                  onTap: () {
                    widget.clear!();
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.clear,
                      size: 15,
                      color: Theme.of(context).buttonColor,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

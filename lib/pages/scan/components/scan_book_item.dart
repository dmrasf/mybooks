import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/database.dart';

class ScanBookItem extends StatefulWidget {
  final String isbn;
  ScanBookItem({Key? key, required this.isbn}) : super(key: key);
  @override
  _ScanBookItemState createState() => _ScanBookItemState();
}

class _ScanBookItemState extends State<ScanBookItem> {
  Uint8List? _cover;
  String? _title;
  String? _ph;
  String? _author;

  @override
  void initState() {
    DataBaseUtil.getBook(isbn: widget.isbn).then(
      (value) async {
        if (value != null) {
          setState(() {
            _title = value.title;
            _ph = value.ph;
            _author = value.author;
            _cover = value.cover;
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                image: _cover == null
                    ? null
                    : DecorationImage(
                        image: MemoryImage(_cover!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: Container(
              width: 70,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  _title == null ? widget.isbn : _title!,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.zcoolXiaoWei(
                    textStyle: TextStyle(
                      color: Theme.of(context).buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 45,
            child: Container(
              width: 20,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: _author == null
                    ? Container(
                        color: Theme.of(context).buttonColor,
                        height: 13,
                        width: 30)
                    : Text(
                        _author!,
                        style: TextStyle(
                          color: Theme.of(context).buttonColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: 70,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: _ph == null
                    ? Container(
                        color: Theme.of(context).buttonColor,
                        height: 10,
                        width: 70)
                    : Text(
                        _ph!,
                        style: GoogleFonts.zcoolXiaoWei(
                          textStyle: TextStyle(
                            color: Theme.of(context).buttonColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

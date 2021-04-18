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
      (value) => setState(() {
        if (value != null) {
          _title = value.title;
          _ph = value.ph;
          _author = value.author;
          _cover = value.cover;
        }
      }),
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
              //child: BackdropFilter(
              //filter: ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6),
              //child: Container(
              //decoration: BoxDecoration(color: Color(0x2f2e2e2e)),
              //),
              //),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
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
                child: _title == null
                    ? Container(color: Colors.black45, height: 10, width: 70)
                    : Text(
                        _title!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.zcoolXiaoWei(
                          textStyle: TextStyle(
                            color: Colors.black87,
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
                    ? Container(color: Colors.black45, height: 13, width: 30)
                    : Text(
                        _author!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
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
                    ? Container(color: Colors.black45, height: 10, width: 70)
                    : Text(
                        _ph!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.zcoolXiaoWei(
                          textStyle: TextStyle(
                            color: Colors.black,
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

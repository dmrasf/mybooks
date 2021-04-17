import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/pages/components/slide_show_dialog.dart';

class ConfirmDialog extends StatefulWidget {
  final String content;
  ConfirmDialog({Key? key, required this.content}) : super(key: key);
  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return SlideShowDialog(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.only(top: 25, bottom: 10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.content,
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text("取消"),
                        onPressed: () => Navigator.of(context).pop(),
                        style: _getButtonStyle(),
                      ),
                      TextButton(
                        child: Text("确认"),
                        onPressed: () => Navigator.of(context).pop(true),
                        style: _getButtonStyle(),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size.zero),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.exo(textStyle: TextStyle(fontWeight: FontWeight.bold)),
      ),
      foregroundColor: MaterialStateProperty.all(Theme.of(context).hintColor),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}

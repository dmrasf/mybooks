import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmDialog extends StatelessWidget {
  final String content;
  ConfirmDialog({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(content),
      contentTextStyle: GoogleFonts.acme(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).buttonColor,
        ),
      ),
      actions: <Widget>[
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
    );
  }

  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size.zero),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.exo(
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      foregroundColor: MaterialStateProperty.all(Colors.orange.shade700),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}

import 'package:flutter/material.dart';

class ScanActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? type;
  ScanActionButton({this.onPressed, required this.title, this.type});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(title),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        )),
        minimumSize: MaterialStateProperty.all(Size(90, 35)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(
          Theme.of(context).buttonColor,
        ),
        overlayColor: MaterialStateProperty.all(
          (type == null ? Theme.of(context).hintColor : type!).withOpacity(0.1),
        ),
        shape: MaterialStateProperty.all(StadiumBorder()),
        side: MaterialStateProperty.all(BorderSide(
          color: type == null ? Theme.of(context).hintColor : type!,
          width: 1,
        )),
      ),
    );
  }
}

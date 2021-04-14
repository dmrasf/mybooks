import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback _press;
  final String _buttonStr;
  LogoutButton(this._press, this._buttonStr);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _press,
      child: Text(_buttonStr),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),
        minimumSize: MaterialStateProperty.all(Size(150, 35)),
        backgroundColor:
            MaterialStateProperty.all(Colors.black.withOpacity(0.3)),
        foregroundColor: MaterialStateProperty.all(Colors.red),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }
}

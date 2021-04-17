import 'package:flutter/material.dart';

class LoginTextButton extends StatelessWidget {
  final VoidCallback _press;
  final String _buttonStr;
  LoginTextButton(this._press, this._buttonStr);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _press,
      child: Text(_buttonStr),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Theme.of(context).hintColor),
      ),
    );
  }
}

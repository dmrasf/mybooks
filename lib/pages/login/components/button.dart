import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _press;
  final String _buttonStr;
  LoginButton(this._press, this._buttonStr);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _press,
      child: Text(_buttonStr),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),
        minimumSize: MaterialStateProperty.all(Size(300, 50)),
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        foregroundColor: MaterialStateProperty.all(
          Theme.of(context).buttonColor.withOpacity(0.9),
        ),
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).backgroundColor.withOpacity(0.2),
        ),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }
}

class LoginInButton extends StatelessWidget {
  final VoidCallback _press;
  final String _buttonStr;
  LoginInButton(this._press, this._buttonStr);
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
        foregroundColor: MaterialStateProperty.all(Colors.orange.shade700),
      ),
    );
  }
}

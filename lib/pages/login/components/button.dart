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
          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),
        minimumSize: MaterialStateProperty.all(Size(150, 35)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.3)),
        side: MaterialStateProperty.all(
            BorderSide(color: Colors.white, width: 1)),
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
        foregroundColor: MaterialStateProperty.all(Colors.orange),
      ),
    );
  }
}

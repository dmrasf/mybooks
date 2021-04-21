import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  MyIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: icon,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(
          Theme.of(context).buttonColor,
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}

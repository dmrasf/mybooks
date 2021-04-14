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
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}

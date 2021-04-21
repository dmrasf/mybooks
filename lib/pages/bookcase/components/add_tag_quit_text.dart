import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTagQuitTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  AddTagQuitTextButton({required this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          GoogleFonts.jua(
            textStyle: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        foregroundColor: MaterialStateProperty.all(
          Theme.of(context).buttonColor,
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}

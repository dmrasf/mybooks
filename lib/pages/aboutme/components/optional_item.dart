import 'package:flutter/material.dart';

class OptionalItem extends StatelessWidget {
  final bool isToggle;
  final GestureTapCallback onPressed;
  final String hintStr;
  OptionalItem({
    Key? key,
    required this.isToggle,
    required this.onPressed,
    required this.hintStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.black.withOpacity(isToggle ? 0.3 : 0.2),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isToggle ? Icons.toggle_on : Icons.toggle_off,
              color: isToggle ? Colors.black : Colors.white,
            ),
            SizedBox(width: 30),
            Text(
              hintStr,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

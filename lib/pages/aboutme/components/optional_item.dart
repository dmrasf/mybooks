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
        color: Theme.of(context).primaryColor.withOpacity(isToggle ? 1 : 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isToggle
                  ? Icons.radio_button_on_sharp
                  : Icons.radio_button_off_sharp,
              color: isToggle
                  ? Theme.of(context).hintColor
                  : Theme.of(context).buttonColor,
              size: 15,
            ),
            SizedBox(width: 15),
            Text(hintStr, style: Theme.of(context).textTheme.headline2),
          ],
        ),
      ),
    );
  }
}

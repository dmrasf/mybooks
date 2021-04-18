import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  FloatButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(40, 40)),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).hintColor),
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
      ),
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation location;
  final double offsetX;
  final double offsetY;
  CustomFloatingActionButtonLocation({
    required this.location,
    this.offsetX = 0,
    this.offsetY = 0,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}

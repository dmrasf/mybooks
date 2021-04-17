import 'package:flutter/material.dart';

class SlideShowDialog extends StatefulWidget {
  final Widget child;
  SlideShowDialog({Key? key, required this.child}) : super(key: key);
  @override
  _SlideShowDialogState createState() => _SlideShowDialogState();
}

class _SlideShowDialogState extends State<SlideShowDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(
        begin: Offset(0, 1),
        end: Offset(0, 0),
      ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller),
      child: widget.child,
    );
  }
}

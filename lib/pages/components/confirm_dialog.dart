import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmDialog extends StatefulWidget {
  final String content;
  ConfirmDialog({Key? key, required this.content}) : super(key: key);
  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(
        begin: Offset(0, 1),
        end: Offset(0, 0),
      ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller!),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 130,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.content,
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text("取消"),
                        onPressed: () => Navigator.of(context).pop(),
                        style: _getButtonStyle(),
                      ),
                      TextButton(
                        child: Text("确认"),
                        onPressed: () => Navigator.of(context).pop(true),
                        style: _getButtonStyle(),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size.zero),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.exo(
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      foregroundColor: MaterialStateProperty.all(Colors.orange.shade700),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}

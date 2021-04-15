import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectDialog extends StatefulWidget {
  final String content;
  final Map<dynamic, dynamic> selected;
  SelectDialog({
    Key? key,
    required this.content,
    required this.selected,
  }) : super(key: key);
  @override
  _SelectDialogState createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  int _index = 0;

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
              padding: EdgeInsets.only(top: 25, bottom: 20),
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
                      SizedBox(height: 25),
                    ] +
                    List.generate(
                      widget.selected.length,
                      (index) => SecretItem(
                        isToggle: _index == index,
                        onPressed: () {
                          setState(() {
                            _index = index;
                          });
                          Navigator.of(context).pop(_index);
                        },
                        hintStr: widget.selected[index]!,
                      ),
                    ),
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
}

class SecretItem extends StatelessWidget {
  final bool isToggle;
  final GestureTapCallback onPressed;
  final String hintStr;
  SecretItem({
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
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 30),
            Icon(
              isToggle
                  ? Icons.radio_button_on_sharp
                  : Icons.radio_button_off_sharp,
              color: isToggle
                  ? Colors.orange.shade700
                  : Theme.of(context).buttonColor,
              size: 15,
            ),
            SizedBox(width: 20),
            Text(
              hintStr,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isToggle
                    ? Colors.orange.shade700
                    : Theme.of(context).buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BookTag extends StatefulWidget {
  final void Function(bool)? listener;
  final String? name;
  final Color activeColor;
  BookTag({
    Key? key,
    this.name,
    this.listener,
    required this.activeColor,
  }) : super(key: key);
  @override
  _BookTagState createState() => _BookTagState();
}

class _BookTagState extends State<BookTag> {
  bool _isToggle = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isToggle = !_isToggle;
          if (widget.listener != null) widget.listener!(_isToggle);
        });
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 35, maxHeight: 20),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: widget.name == null
              ? null
              : Text(
                  widget.name!,
                  style: TextStyle(
                    color: _isToggle
                        ? Colors.black54
                        : Theme.of(context).buttonColor,
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isToggle ? widget.activeColor : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          border: Border.all(
            color:
                _isToggle ? widget.activeColor : Theme.of(context).buttonColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}

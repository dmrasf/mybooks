import 'package:flutter/material.dart';

class BookTag extends StatefulWidget {
  final void Function(bool)? listener;
  final String? name;
  final Color activeColor;
  final bool? isToggle;
  BookTag({
    Key? key,
    this.name,
    this.listener,
    required this.activeColor,
    this.isToggle,
  }) : super(key: key);
  @override
  _BookTagState createState() => _BookTagState();
}

class _BookTagState extends State<BookTag> {
  late bool _isToggle;

  @override
  void initState() {
    if (widget.isToggle == null)
      _isToggle = false;
    else
      _isToggle = widget.isToggle!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.listener != null) {
                  _isToggle = !_isToggle;
                  widget.listener!(_isToggle);
                }
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
                  color: _isToggle
                      ? widget.activeColor
                      : Theme.of(context).buttonColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

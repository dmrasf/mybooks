import 'package:flutter/material.dart';

class LoginActionButton extends StatefulWidget {
  final Future<bool> Function() action;
  final Widget initWidget;
  LoginActionButton({
    Key? key,
    required this.action,
    required this.initWidget,
  }) : super(key: key);
  @override
  _LoginActionButtonState createState() => _LoginActionButtonState();
}

class _LoginActionButtonState extends State<LoginActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Widget _current = widget.initWidget;
  final Icon _waitIcon = Icon(
    Icons.refresh,
    size: 30,
    color: Color(0xff404040),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (_controller.isAnimating) return;
        _controller.repeat();
        setState(() {
          _current = _waitIcon;
        });
        widget.action().then((isSuccessed) {
          setState(() {
            _current = widget.initWidget;
          });
          _controller.reset();
        });
      },
      child: RotationTransition(
        turns: _controller,
        child: _current,
      ),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),
        minimumSize: MaterialStateProperty.all(Size(300, 50)),
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        foregroundColor: MaterialStateProperty.all(Color(0xff303030)),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }
}

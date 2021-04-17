import 'package:flutter/material.dart';

class WaitActionIconButton extends StatefulWidget {
  final Future<bool> Function()? action;
  final IconData startIcon;
  final IconData waitIcon;
  final IconData endIcon;
  final double iconSize;
  final Color? iconColor;
  WaitActionIconButton({
    Key? key,
    this.action,
    this.startIcon = Icons.check,
    this.waitIcon = Icons.autorenew,
    this.endIcon = Icons.refresh,
    this.iconSize = 17,
    this.iconColor,
  }) : super(key: key);

  @override
  _WaitActionIconButtonState createState() => _WaitActionIconButtonState();
}

class _WaitActionIconButtonState extends State<WaitActionIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late IconData _currentIcon;

  @override
  void initState() {
    super.initState();
    _currentIcon = widget.startIcon;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: RotationTransition(
        turns: _controller,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          child: Icon(
            _currentIcon,
            size: widget.iconSize,
            color: widget.iconColor,
          ),
        ),
      ),
      onTap: () {
        if (widget.action == null) return;
        if (_controller.isAnimating) return;
        _controller.repeat();
        setState(() {
          _currentIcon = widget.waitIcon;
        });
        widget.action!().then((isSuccessed) {
          setState(() {
            if (isSuccessed)
              _currentIcon = widget.startIcon;
            else
              _currentIcon = widget.endIcon;
          });
          _controller.reset();
        });
      },
    );
  }
}

import 'package:flutter/material.dart';

class AddTags extends StatelessWidget {
  final VoidCallback? onTap;
  AddTags({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: '#',
        child: Container(
          padding: EdgeInsets.all(5),
          color: Colors.transparent,
          child: Icon(
            Icons.tag,
            size: 12,
            color: Theme.of(context).buttonColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

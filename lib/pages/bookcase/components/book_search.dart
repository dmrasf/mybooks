import 'package:flutter/material.dart';

class BookSearch extends StatelessWidget {
  final double width;
  BookSearch({required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        padding: EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        height: 40,
        child: Icon(
          Icons.search,
          size: 10,
          color: Theme.of(context).buttonColor,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}

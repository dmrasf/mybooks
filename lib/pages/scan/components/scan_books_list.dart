import 'package:flutter/material.dart';

class ScanBooksList extends StatelessWidget {
  final List<String> isbns;
  ScanBooksList({required this.isbns});
  @override
  Widget build(BuildContext context) {
    print(isbns);
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: List.generate(isbns.length, (index) => Text(isbns[index])),
      ),
    );
  }
}

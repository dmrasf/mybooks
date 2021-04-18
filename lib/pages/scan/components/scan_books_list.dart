import 'package:flutter/material.dart';
import 'package:mybooks/pages/scan/components/scan_book_item.dart';

class ScanBooksList extends StatelessWidget {
  final List<String> isbns;
  ScanBooksList({required this.isbns});

  @override
  Widget build(BuildContext context) {
    print(isbns);
    return Container(
      color: Theme.of(context).primaryColor,
      height: 100 / 2 * 3 + 10,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 5, right: 5, top: 10),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ScanBookItem(isbn: isbns[index]),
              childCount: isbns.length,
            ),
            itemExtent: 120,
          ),
        ],
      ),
    );
  }
}

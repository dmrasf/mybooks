import 'package:flutter/material.dart';
import 'package:mybooks/pages/scan/components/scan_book_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanBooksList extends StatelessWidget {
  final List<String> isbns;
  ScanBooksList({Key? key, required this.isbns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isbns.isEmpty
        ? SizedBox(
            height: 100 / 2 * 3 + 10,
            child: Container(
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/nothing.svg',
                color: Theme.of(context).buttonColor.withOpacity(0.6),
                width: 100,
              ),
            ),
          )
        : Container(
            color: Theme.of(context).primaryColor,
            height: 100 / 2 * 3 + 10,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
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

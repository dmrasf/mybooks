import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/bookcase/components/book_list_item.dart';

class ShowBooksGrid extends StatelessWidget {
  final List<String> showBooks;
  ShowBooksGrid({Key? key, required this.showBooks}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return Expanded(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: userProvider.crossAxisCount,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => BookShowListItem(
                isbn: showBooks[index],
                crossAxisCount: userProvider.crossAxisCount,
              ),
              childCount: showBooks.length,
            ),
          ),
        ],
      ),
    );
  }
}

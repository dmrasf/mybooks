import 'package:flutter/material.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/bookcase/components/book_tag.dart';
import 'package:mybooks/pages/bookcase/components/book_search.dart';
import 'package:mybooks/pages/bookcase/components/change_crossAxisCount.dart';
import 'package:mybooks/pages/bookcase/components/add_tags_page.dart';
import 'package:mybooks/pages/bookcase/components/choose_tags.dart';
import 'package:mybooks/pages/bookcase/components/set_order.dart';

class BooksShowControllerBar extends StatelessWidget {
  final void Function() sortCallBack;
  final void Function() listener;
  BooksShowControllerBar({required this.sortCallBack, required this.listener});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      height: 40,
      child: Row(
        children: [
          AddTags(
            onTap: () => ChangePage.fadeChangePage(
                context,
                TagsChoosePage(
                  userTags: userProvider.tags,
                  isTagsUnion: userProvider.isTagsUnion,
                )).then((value) {
              if (value == null) return;
              userProvider.tags = value[0];
              userProvider.isTagsUnion = value[1];
              listener();
            }),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              children: List.generate(
                userProvider.tags.length,
                (i) => BookTag(
                  key: UniqueKey(),
                  activeColor: Theme.of(context).hintColor,
                  name: userProvider.tags.keys.toList()[i],
                  isToggle:
                      userProvider.tags[userProvider.tags.keys.toList()[i]],
                  listener: (isToggle) {
                    if (userProvider.tags[userProvider.tags.keys.toList()[i]] ==
                        isToggle) return;
                    userProvider.tag =
                        MapEntry(userProvider.tags.keys.toList()[i], isToggle);
                    listener();
                  },
                ),
              ),
            ),
          ),
          Spacer(),
          SetOrder(
            sortType: userProvider.sortType,
            listener: (sortType) {
              if (userProvider.sortType == sortType) return;
              userProvider.sortType = sortType;
              sortCallBack();
              listener();
            },
          ),
          ChangeCrossAxisCount(
            crossAxisCount: userProvider.crossAxisCount,
            onPressed: () {
              userProvider.crossAxisCount =
                  (userProvider.crossAxisCount - 1) % 4 + 2;
              listener();
            },
          ),
          BookSearch(width: MediaQuery.of(context).size.width * 0.17),
        ],
      ),
    );
  }
}

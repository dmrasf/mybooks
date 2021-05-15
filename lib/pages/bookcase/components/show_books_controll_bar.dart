import 'package:flutter/material.dart';
import 'package:mybooks/models/booksShowStatus_provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';
import 'package:mybooks/pages/components/select_dialog.dart';
import 'package:mybooks/pages/components/toast.dart';
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
              ),
            ).then((value) {
              if (value == null) return;
              userProvider.tags = value[0];
              userProvider.isTagsUnion = value[1];
              sortCallBack();
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
                    sortCallBack();
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
          //BookSearch(width: MediaQuery.of(context).size.width * 0.17),
        ],
      ),
    );
  }
}

class BooksShowSelectedControllerBar extends StatelessWidget {
  final List<String> allShowBooks;
  final void Function() sortCallBack;

  BooksShowSelectedControllerBar(
      {required this.allShowBooks, required this.sortCallBack});

  @override
  Widget build(BuildContext context) {
    final myBooksShowStatusProvider =
        Provider.of<MyBooksShowStatusModel>(context);
    final userBooksProvider = Provider.of<MyUserBooksModel>(context);
    final userProvider = Provider.of<MyUserModel>(context);
    Map<String, String> allTags = {};
    Map<String, String> existTags = {};
    userProvider.tags.keys.forEach((tag) {
      allTags[tag] = tag;
    });
    userBooksProvider.userBooksTag.values.forEach((tags) {
      tags.forEach((tag) {
        existTags[tag] = tag;
      });
    });
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BooksSelectedControllItem(
            title: '标记阅读状态',
            onPressed: () {
              if (myBooksShowStatusProvider.selectedBooks.isEmpty) {
                showToast(context, '请先选择');
                return;
              }
              showDialog(
                context: context,
                builder: (context) => SelectDialog(
                  content: '标记阅读状态',
                  selected: {0: '未读', 1: '已读', 2: '未知'},
                ),
                barrierColor: Colors.transparent,
              ).then((value) {
                if (value == null) return;
                myBooksShowStatusProvider.selectedBooks.forEach((isbn) {
                  userBooksProvider.changeUserBookRead(
                      isbn, value == 2 ? null : value);
                });
                myBooksShowStatusProvider.isSelected = false;
                myBooksShowStatusProvider.clearAllSelected();
              });
            },
          ),
          SizedBox(width: 5),
          BooksSelectedControllItem(
            title: '添加标签',
            onPressed: () {
              if (allTags.isEmpty) {
                showToast(context, '没有可添加的标签');
                return;
              }
              if (myBooksShowStatusProvider.selectedBooks.isEmpty) {
                showToast(context, '请先选择');
                return;
              }
              showDialog(
                context: context,
                builder: (context) => SelectDialog(
                  content: '添加标签',
                  selected: allTags,
                ),
                barrierColor: Colors.transparent,
              ).then((value) {
                if (value == null) return;
                myBooksShowStatusProvider.selectedBooks.forEach((isbn) {
                  userBooksProvider.changeUserBookTag(isbn, value, true);
                });
                myBooksShowStatusProvider.isSelected = false;
                myBooksShowStatusProvider.clearAllSelected();
                sortCallBack();
              });
            },
          ),
          SizedBox(width: 5),
          BooksSelectedControllItem(
            title: '删除标签',
            onPressed: () {
              if (existTags.isEmpty) {
                showToast(context, '没有可删除的标签');
                return;
              }
              if (myBooksShowStatusProvider.selectedBooks.isEmpty) {
                showToast(context, '请先选择');
                return;
              }
              showDialog(
                context: context,
                builder: (context) => SelectDialog(
                  content: '删除标签',
                  selected: existTags,
                ),
                barrierColor: Colors.transparent,
              ).then((value) {
                if (value == null) return;
                myBooksShowStatusProvider.selectedBooks.forEach((isbn) {
                  userBooksProvider.changeUserBookTag(isbn, value, false);
                });
                myBooksShowStatusProvider.isSelected = false;
                myBooksShowStatusProvider.clearAllSelected();
                sortCallBack();
              });
            },
          ),
          SizedBox(width: 5),
          BooksSelectedControllItem(
            title: '删除书籍',
            onPressed: () {
              if (myBooksShowStatusProvider.selectedBooks.isEmpty) {
                showToast(context, '请先选择');
                return;
              }
              showDialog(
                context: context,
                builder: (context) => ConfirmDialog(content: '确认删除'),
              ).then((value) {
                if (value == null) return;
                if (value) {
                  Set<String> allSelected =
                      Set.unmodifiable(myBooksShowStatusProvider.selectedBooks);
                  print(allSelected.toString());
                  userBooksProvider.deleteUserBooks(allSelected.toList());
                  myBooksShowStatusProvider.setIsSelected(false);
                }
              });
            },
          ),
          BookTag(
            activeColor: Theme.of(context).hintColor,
            name: '全选',
            listener: (isToggle) {
              if (isToggle)
                myBooksShowStatusProvider.addAllSelected(allShowBooks);
              else
                myBooksShowStatusProvider.clearAllSelected();
            },
          ),
          BooksSelectedControllItem(
            title: '退出',
            onPressed: () {
              myBooksShowStatusProvider.isSelected = false;
              myBooksShowStatusProvider.clearAllSelected();
            },
          ),
        ],
      ),
    );
  }
}

class BooksSelectedControllItem extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  BooksSelectedControllItem({this.onPressed, required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Container(
          constraints: BoxConstraints(minWidth: 35, maxHeight: 20),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).buttonColor,
                fontSize: 7,
                fontWeight: FontWeight.bold,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(
              color: Theme.of(context).buttonColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

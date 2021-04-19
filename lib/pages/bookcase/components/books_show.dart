import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/utils/database.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/bookcase/components/bookcase_title_card.dart';
import 'package:mybooks/pages/bookcase/components/book_list_item.dart';
import 'package:mybooks/pages/bookcase/components/book_tag.dart';

class BooksShow extends StatefulWidget {
  final List<UserBook> books;
  BooksShow({Key? key, required this.books}) : super(key: key);
  @override
  _BooksShowState createState() => _BooksShowState();
}

class _BooksShowState extends State<BooksShow> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    userProvider.books = widget.books.length;
    return Container(
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Column(
        children: [
          BookcaseTitleCard(),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
            height: 43,
            child: Row(
              children: [
                Icon(
                  Icons.tag,
                  size: 12,
                  color: Theme.of(context).buttonColor,
                ),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      BookTag(
                        activeColor: Theme.of(context).errorColor,
                        name: '艺术',
                        listener: (isToggle) {
                          print(isToggle);
                        },
                      ),
                      SizedBox(width: 10),
                      BookTag(
                        activeColor: Theme.of(context).hintColor,
                        name: '小说',
                        listener: (isToggle) {
                          print(isToggle);
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
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
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        BookShowListItem(isbn: widget.books[index].isbn),
                    childCount: widget.books.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

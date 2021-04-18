import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/nothing_page.dart';
import 'package:mybooks/pages/bookcase/components/books_show.dart';

class BookcasePage extends StatelessWidget {
  final List<UserBook>? userBooks;
  BookcasePage({Key? key, this.userBooks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    if (userBooks == null) return NothingPage(title: '没有书');
    userProvider.books = userBooks!.length;
    if (userBooks!.isEmpty)
      return NothingPage(title: '没有书');
    else
      return BooksShow(books: userBooks!);
  }
}

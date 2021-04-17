import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/nothing_page.dart';
import 'package:mybooks/pages/components/loading_page.dart';
import 'package:mybooks/pages/components/toast.dart';
import 'package:mybooks/pages/bookcase/components/books_show.dart';

class BookcasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return FutureBuilder<List<UserBook>>(
      future: DataBaseUtil.getUserBooks(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        late Widget child;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            child = NothingPage();
            showToast(context, snapshot.error!.toString(),
                type: ToastType.ERROR);
          }
          userProvider.books = (snapshot.data as List<UserBook>).length;
          if ((snapshot.data as List<UserBook>).isEmpty)
            child = NothingPage();
          else
            child = BooksShow(books: snapshot.data);
        } else
          child = LoadingPage();
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          switchOutCurve: Curves.easeOut,
          child: child,
        );
      },
    );
  }
}

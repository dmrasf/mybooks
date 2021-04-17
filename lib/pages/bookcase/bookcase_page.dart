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
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            showToast(context, '构建数据库失败，请退出重试', type: ToastType.ERROR);
            return NothingPage();
          }
          userProvider.books = (snapshot.data as List<UserBook>).length;
          if ((snapshot.data as List<UserBook>).isEmpty)
            return NothingPage();
          else
            return BooksShow(books: snapshot.data);
        } else
          return LoadingPage();
      },
    );
  }
}

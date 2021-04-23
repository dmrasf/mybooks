import 'package:flutter/material.dart';
import 'package:mybooks/pages/components/nothing_page.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';
import 'package:mybooks/pages/record/components/items_show.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyUserBooksModel>(
      builder: (context, myUserBooksModel, child) =>
          myUserBooksModel.userBooks.isEmpty
              ? NothingPage(title: '还是没有书')
              : RecordItemsShow(
                  userBooks: myUserBooksModel.userBooks.keys.toList(),
                ),
    );
  }
}

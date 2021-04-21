import 'package:flutter/material.dart';
import 'package:mybooks/pages/components/nothing_page.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';

class RecordPage extends StatefulWidget {
  RecordPage({Key? key}) : super(key: key);
  @override
  RecordPageState createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyUserBooksModel>(
        builder: (context, myUserBooksModel, child) {
      if (myUserBooksModel.userBooks.isEmpty)
        return NothingPage(title: '还是没有书');
      else
        return Container();
    });
  }
}

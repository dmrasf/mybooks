import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/nothing_page.dart';

class RecordPage extends StatefulWidget {
  RecordPage({Key? key}) : super(key: key);
  @override
  RecordPageState createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  List<UserBook>? _userBooks;

  @override
  void initState() {
    updateUserBooks();
    super.initState();
  }

  void updateUserBooks() async {
    _userBooks = await DataBaseUtil.getUserBooks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_userBooks == null) return NothingPage(title: '还是没有书');
    if (_userBooks!.isEmpty)
      return NothingPage(title: '还是没有书');
    else
      return Container();
  }
}

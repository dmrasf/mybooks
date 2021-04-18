import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/nothing_page.dart';

class RecordPage extends StatelessWidget {
  final List<UserBook>? userBooks;
  RecordPage({Key? key, this.userBooks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userBooks == null) return NothingPage(title: '还是没有书');
    if (userBooks!.isEmpty)
      return NothingPage(title: '还是没有书');
    else
      return Container();
  }
}

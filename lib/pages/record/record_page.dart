import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/nothing_page.dart';

class RecordPage extends StatelessWidget {
  final List<UserBook>? userBooks;
  RecordPage({Key? key, this.userBooks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    if (userBooks == null) return NothingPage();
    if (userBooks!.isEmpty)
      return NothingPage();
    else
      return Container();
  }
}

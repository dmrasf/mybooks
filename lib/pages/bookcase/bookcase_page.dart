import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'package:mybooks/pages/components/nothing_page.dart';
import 'package:mybooks/pages/bookcase/components/books_show.dart';
import 'package:mybooks/pages/components/float_button.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/pages/scan/scan_barcode_page.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'dart:convert';

class BookcasePage extends StatefulWidget {
  BookcasePage({Key? key}) : super(key: key);
  @override
  BookcasePageState createState() => BookcasePageState();
}

class BookcasePageState extends State<BookcasePage> {
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
    final userProvider = Provider.of<MyUserModel>(context);
    Set<String> existTags = Set();
    if (_userBooks != null) {
      userProvider.books = _userBooks!.length;
      _userBooks!.forEach((userBook) {
        if (userBook.tags == null) return;
        List<String> tags = jsonDecode(userBook.tags!);
        tags.forEach((e) {
          existTags.add(e);
          if (userProvider.tags.containsKey(e)) return;
          userProvider.tags[e] = false;
        });
      });
    }
    return Scaffold(
      body: _userBooks == null
          ? NothingPage(title: '没有书')
          : _userBooks!.isEmpty
              ? NothingPage(title: '没有书')
              : BooksShow(books: _userBooks!, existTags: existTags),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatButton(
        child: Icon(Icons.add, size: 15),
        onPressed: () => ChangePage.fadeChangePage(context, ScanBarCodePage()),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
        location: FloatingActionButtonLocation.endFloat,
        offsetX: -5,
        offsetY: -20,
      ),
    );
  }
}

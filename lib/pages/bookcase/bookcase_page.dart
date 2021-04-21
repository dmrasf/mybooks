import 'package:flutter/material.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/components/nothing_page.dart';
import 'package:mybooks/pages/bookcase/components/books_show.dart';
import 'package:mybooks/pages/components/float_button.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/pages/scan/scan_barcode_page.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/userbooks_provider.dart';

class BookcasePage extends StatefulWidget {
  BookcasePage({Key? key}) : super(key: key);
  @override
  BookcasePageState createState() => BookcasePageState();
}

class BookcasePageState extends State<BookcasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyUserBooksModel>(
        builder: (context, myUserBooksModel, child) {
          Set<String> existTags = Set();
          myUserBooksModel.userBooksTag.values.forEach((tags) {
            existTags.addAll(tags);
          });
          context.read<MyUserModel>().books = myUserBooksModel.userBooks.length;
          return myUserBooksModel.userBooks.isEmpty
              ? NothingPage(title: '没有书')
              : BooksShow(
                  books: myUserBooksModel.userBooks.values.toList(),
                  existTags: existTags,
                );
        },
      ),
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

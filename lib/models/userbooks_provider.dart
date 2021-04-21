import 'package:flutter/material.dart';
import 'package:mybooks/utils/database.dart';
import 'dart:convert';

class MyUserBooksModel extends ChangeNotifier {
  Map<String, UserBook> userBooks = {};
  Map<String, Set<String>> userBooksTag = {};
  bool _init = false;

  void quit() {
    _init = false;
  }

  bool initUserBooks() {
    if (_init == true) return true;
    _init = true;
    DataBaseUtil.getUserBooks().then((_userBooks) {
      userBooks.clear();
      _userBooks.forEach((userBook) {
        userBooks[userBook.isbn] = userBook;
        userBooksTag[userBook.isbn] = Set();
        if (userBook.tags == null) return;
        List<String> tags = jsonDecode(userBook.tags!);
        tags.forEach(
          (e) => userBooksTag[userBook.isbn]!.add(e),
        );
      });
      notifyListeners();
    });
    return true;
  }

  /// 添加书籍
  Future<bool> addUserBook(UserBook userBook) async {
    if (userBooks.containsKey(userBook.isbn)) return false;
    bool isWork = await DataBaseUtil.addUserBook(userBook);
    if (isWork) {
      userBooks[userBook.isbn] = userBook;
      userBooksTag[userBook.isbn] = Set();
      notifyListeners();
    } else
      return false;
    return true;
  }

  /// 删除书籍
  Future<bool> deleteUserBook(String isbn) async {
    if (!userBooks.containsKey(isbn)) return false;
    userBooks.remove(isbn);
    userBooksTag.remove(isbn);
    await DataBaseUtil.deleteUserBook(isbn: isbn);
    notifyListeners();
    return true;
  }

  /// 修改标签
  void changeUserBookTag(String isbn, String tag, bool isAdd) {
    if (!userBooks.containsKey(isbn)) return;
  }

  /// 修改评论
  void changeUserBookDescription(String isbn, String description) {
    if (!userBooks.containsKey(isbn)) return;
  }

  /// 修改已读状态
  void changeUserBookRead(String isbn, bool isRead) {
    if (!userBooks.containsKey(isbn)) return;
  }

  /// 修改评分
  void changeUserBookRate(String isbn, double rate) {
    if (!userBooks.containsKey(isbn)) return;
  }
}

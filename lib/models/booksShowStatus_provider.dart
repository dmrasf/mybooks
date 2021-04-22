import 'package:flutter/material.dart';

class MyBooksShowStatusModel extends ChangeNotifier {
  Set<String> selectedBooks = Set();
  bool _isSelected = false;

  bool get isSelected => _isSelected;
  set isSelected(bool isSelected) {
    if (_isSelected == isSelected) return;
    _isSelected = isSelected;
    selectedBooks.clear();
    notifyListeners();
  }

  void setIsSelected(bool isSelected) {
    if (_isSelected == isSelected) return;
    _isSelected = isSelected;
    selectedBooks.clear();
  }

  /// 选择书籍  添加还是删除
  void selectedBook(String isbn, bool isAdd) {
    if (isAdd)
      selectedBooks.add(isbn);
    else
      selectedBooks.remove(isbn);
  }

  /// 清空
  void clearAllSelected() {
    selectedBooks.clear();
    notifyListeners();
  }

  /// 增加所有
  void addAllSelected(List<String> allShowBooks) {
    selectedBooks.addAll(allShowBooks);
    notifyListeners();
  }
}

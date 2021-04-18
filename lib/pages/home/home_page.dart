import 'package:flutter/material.dart';
import 'package:mybooks/pages/bookcase/bookcase_page.dart';
import 'package:mybooks/pages/record/record_page.dart';
import 'package:mybooks/pages/aboutme/aboutme_page.dart';
import 'package:mybooks/pages/components/toast.dart';
import 'package:mybooks/utils/database.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  DateTime? _popTime;
  List<UserBook>? _userBooks;

  @override
  void initState() {
    updateUserBooks();
    super.initState();
  }

  void updateUserBooks() async {
    _userBooks = await DataBaseUtil.getUserBooks();
    if (_currentIndex != 2) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: [
          SafeArea(child: BookcasePage(userBooks: _userBooks)),
          SafeArea(child: RecordPage(userBooks: _userBooks)),
          SafeArea(child: AboutmePage()),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _currentIndex,
          selectedIconTheme: IconThemeData(size: 18),
          unselectedIconTheme: IconThemeData(size: 16),
          selectedLabelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          unselectedItemColor: Theme.of(context).buttonColor.withOpacity(0.4),
          selectedItemColor: Theme.of(context).buttonColor.withOpacity(0.8),
          onTap: (index) {
            if (_currentIndex != index)
              setState(() {
                _currentIndex = index;
              });
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.book),
              ),
              label: '家',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.animation),
              ),
              label: '记录',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person),
              ),
              label: '我',
            ),
          ],
        ),
      ),
      onWillPop: () async {
        if (_popTime == null ||
            DateTime.now().difference(_popTime!) >
                Duration(milliseconds: 500)) {
          _popTime = DateTime.now();
          showToast(context, '再按一次退出');
          return false;
        }
        _popTime = DateTime.now();
        return true;
      },
    );
  }
}

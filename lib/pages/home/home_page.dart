import 'package:flutter/material.dart';
import 'package:mybooks/pages/bookcase/bookcase_page.dart';
import 'package:mybooks/pages/record/record_page.dart';
import 'package:mybooks/pages/aboutme/aboutme_page.dart';
import 'package:mybooks/pages/components/toast.dart';

class HomePage extends StatefulWidget {
  final List<Widget> _screens = [
    SafeArea(child: BookcasePage()),
    SafeArea(child: RecordPage()),
    SafeArea(child: AboutmePage()),
  ];
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  DateTime? _popTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: widget._screens),
        backgroundColor: Theme.of(context).backgroundColor,
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
            if (_currentIndex != index) setState(() => _currentIndex = index);
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

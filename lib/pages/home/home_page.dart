import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/aboutme_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        SafeArea(child: Container(color: Theme.of(context).backgroundColor)),
        SafeArea(child: AboutmePage()),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).buttonColor,
        selectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Theme.of(context).buttonColor.withOpacity(0.3),
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '家'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/utils/location.dart';
import 'package:provider/provider.dart';
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
        SafeArea(child: Container(color: Colors.black.withOpacity(0.7))),
        SafeArea(child: AboutmePage()),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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

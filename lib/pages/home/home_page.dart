import 'package:flutter/material.dart';
import 'package:mybooks/utils/location.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MBLocalizations.of(context).title),
      ),
      body: Container(),
    );
  }
}

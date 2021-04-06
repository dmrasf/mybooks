import 'package:flutter/material.dart';
import 'package:mybooks/models/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var provider = Provider.of<MyThemeModel>(context, listen: false);
          provider.isLightTheme = !provider.isLightTheme;
        },
        child: Icon(Icons.sd),
      ),
    );
  }
}

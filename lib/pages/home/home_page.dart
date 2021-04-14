import 'package:flutter/material.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/utils/location.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<MyUserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(MBLocalizations.of(context).title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
        child: Icon(Icons.face),
      ),
    );
  }
}

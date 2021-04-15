import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';

class ProfileSettingPage extends StatefulWidget {
  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '个人资料'),
      body: Container(),
    );
  }
}

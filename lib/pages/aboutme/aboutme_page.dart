import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/button.dart';
import 'package:mybooks/pages/aboutme/components/img_name.dart';
import 'package:mybooks/pages/aboutme/components/info.dart';
import 'package:mybooks/pages/aboutme/components/setting.dart';

class AboutmePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              AboutmeImgName(),
              SizedBox(height: 10),
              AboutmeInfo(),
              SizedBox(height: 10),
              AboutmeSetting(),
            ],
          ),
          Spacer(),
          LogoutButton(() {
            Navigator.of(context).pushReplacementNamed('/login');
          }, '取消登录'),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

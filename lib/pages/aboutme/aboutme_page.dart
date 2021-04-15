import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/button.dart';
import 'package:mybooks/pages/aboutme/components/img_name.dart';
import 'package:mybooks/pages/aboutme/components/info.dart';
import 'package:mybooks/pages/aboutme/components/setting.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';

class AboutmePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).backgroundColor,
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
            showDialog<bool>(
              context: context,
              builder: (context) => ConfirmDialog(content: '确认退出？'),
            ).then((isConfirm) {
              if (isConfirm != null) if (isConfirm)
                Navigator.of(context).pushReplacementNamed('/login');
            });
          }, '取消登录'),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

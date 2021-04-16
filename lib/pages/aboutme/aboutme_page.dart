import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/button.dart';
import 'package:mybooks/pages/aboutme/components/img_name.dart';
import 'package:mybooks/pages/aboutme/components/info.dart';
import 'package:mybooks/pages/aboutme/components/setting.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';

class AboutmePage extends StatefulWidget {
  @override
  _AboutmePageState createState() => _AboutmePageState();
}

class _AboutmePageState extends State<AboutmePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              AboutmeImgName(
                avatarUrl: userProvider.avatarUrl,
                name: userProvider.name,
                description: userProvider.description,
              ),
              SizedBox(height: 10),
              AboutmeInfo(),
              SizedBox(height: 10),
              AboutmeSetting(updateState: () => setState(() {})),
              SizedBox(height: 10),
              AboutmeSettingItem(
                icon: Icons.remove_circle,
                title: '取消登录',
                titleColor: Colors.orange.shade700,
                hint: '',
                onPressed: () => showDialog<bool>(
                  context: context,
                  builder: (context) => ConfirmDialog(content: '确认退出？'),
                  barrierColor: Colors.transparent,
                ).then((isConfirm) {
                  if (isConfirm != null) if (isConfirm) {
                    userProvider.isLogin = false;
                    Navigator.of(context).pushReplacementNamed('/login');
                  }
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

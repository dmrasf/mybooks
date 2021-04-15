import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/aboutme/components/setting.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';

class ProfileSettingPage extends StatefulWidget {
  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '个人资料'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              AboutmeSettingItem(title: '头像', icon: Icons.image),
              SizedBox(height: 20),
              AboutmeSettingItem(
                title: '昵称',
                icon: Icons.face,
                hint: userProvider.name == '' ? null : userProvider.name,
                onPressed: () {},
              ),
              AboutmeSettingItem(
                title: '个性签名',
                icon: Icons.code,
                hint: userProvider.description == ''
                    ? null
                    : userProvider.description,
              ),
              AboutmeSettingItem(
                title: '地区',
                icon: Icons.location_on,
                hint:
                    userProvider.location == '' ? null : userProvider.location,
              ),
              AboutmeSettingItem(
                title: '生日',
                icon: Icons.cake,
                hint:
                    userProvider.birthday == '' ? null : userProvider.birthday,
              ),
              AboutmeSettingItem(
                title: '性别',
                icon: Icons.category_outlined,
                hint: userProvider.gender == null
                    ? null
                    : userProvider.gender!
                        ? '男'
                        : '女',
              ),
              SizedBox(height: 20),
              AboutmeSettingItem(title: '隐私', icon: Icons.security),
              SizedBox(height: 20),
              AboutmeSettingItem(
                title: '注销帐号',
                titleColor: Colors.red,
                hint: '',
                icon: Icons.power_settings_new_sharp,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

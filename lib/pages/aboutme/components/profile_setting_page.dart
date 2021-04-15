import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/aboutme/components/setting.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';
import 'package:mybooks/pages/components/confirm_dialog.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/pages/aboutme/components/name_setting_page.dart';
import 'package:mybooks/pages/aboutme/components/description_setting_page.dart';
import 'package:location/location.dart';
import 'package:mybooks/pages/aboutme/components/gender_setting_page.dart';
import 'package:mybooks/pages/aboutme/components/secrets_setting_page.dart';

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
              SizedBox(height: 15),
              AboutmeSettingItem(
                title: '昵称',
                icon: Icons.face,
                hint: userProvider.name == '' ? null : userProvider.name,
                onPressed: () => ChangePage.slideChangePage(
                  context,
                  NameSettingPage(),
                ).then((value) {
                  if (value) setState(() {});
                }),
              ),
              AboutmeSettingItem(
                title: '个性签名',
                icon: Icons.code,
                hint: userProvider.description == ''
                    ? null
                    : userProvider.description,
                onPressed: () => ChangePage.slideChangePage(
                  context,
                  DescriptionSettingPage(),
                ).then((value) {
                  if (value) setState(() {});
                }),
              ),
              AboutmeSettingItem(
                title: '地区',
                icon: Icons.location_on,
                hint:
                    userProvider.location == null ? '' : userProvider.location,
                onPressed: () async {
                  return;
                  Location location = Location();
                  print('=================');
                  bool _serviceEnabled = await location.serviceEnabled();
                  if (!_serviceEnabled) {
                    _serviceEnabled = await location.requestService();
                    if (!_serviceEnabled) {
                      return;
                    }
                  }
                  PermissionStatus _permissionGranted =
                      await location.hasPermission();
                  if (_permissionGranted == PermissionStatus.denied) {
                    _permissionGranted = await location.requestPermission();
                    if (_permissionGranted != PermissionStatus.granted) {
                      return;
                    }
                  }
                  print('=================3');
                  LocationData locationData = await location.getLocation();
                  print(locationData);
                },
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
                    ? '未知'
                    : userProvider.gender!
                        ? '男'
                        : '女',
                onPressed: () => ChangePage.slideChangePage(
                  context,
                  GenderSettingPage(),
                ).then((_) => setState(() {})),
              ),
              SizedBox(height: 15),
              AboutmeSettingItem(
                title: '隐私',
                icon: Icons.security,
                onPressed: () => ChangePage.slideChangePage(
                  context,
                  SecretsSettingPage(),
                ),
              ),
              AboutmeSettingItem(
                title: '开源协议',
                icon: Icons.source,
                onPressed: () {
                  showLicensePage(
                    context: context,
                    applicationVersion: '1.0.0',
                    applicationName: '我的书籍',
                  );
                },
              ),
              SizedBox(height: 15),
              AboutmeSettingItem(
                title: '注销帐号',
                titleColor: Colors.red,
                hint: '',
                icon: Icons.power_settings_new_sharp,
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (context) => ConfirmDialog(
                      content: '确认注销？将丢失所有信息',
                    ),
                    barrierColor: Colors.transparent,
                  ).then((isConfirm) {
                    if (isConfirm != null) if (isConfirm) {
                      // 服务器 .then
                      //userProvider.isLogin = false;
                      //Navigator.of(context).pushReplacementNamed('/login');
                    }
                  });
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

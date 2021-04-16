import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/aboutme/components/setting.dart';
import 'package:mybooks/pages/components/select_dialog.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';

const SecretsType = {0: '所有人禁止', 1: '我关注的', 2: '关注我的', 3: '互相关注', 4: '所有人'};
const _TypeString = {
  0: '我的书籍',
  1: '邮箱',
  2: '我关注的人',
  3: '关注我的人',
  4: '地区',
  5: '性别',
};
const _TypeIcon = {
  0: Icons.bookmarks,
  1: Icons.email,
  2: Icons.looks,
  3: Icons.people,
  4: Icons.location_on,
  5: Icons.category_outlined,
};

class SecretsSettingPage extends StatefulWidget {
  @override
  _SecretsSettingPageState createState() => _SecretsSettingPageState();
}

class _SecretsSettingPageState extends State<SecretsSettingPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    final setValue = {
      0: (value) => userProvider.booksSecret = value,
      1: (value) => userProvider.emailSecret = value,
      2: (value) => userProvider.followingSecret = value,
      3: (value) => userProvider.followersSecret = value,
      4: (value) => userProvider.locationSecret = value,
      5: (value) => userProvider.genderSecret = value,
    };
    final getValue = {
      0: userProvider.booksSecret,
      1: userProvider.emailSecret,
      2: userProvider.followingSecret,
      3: userProvider.followersSecret,
      4: userProvider.locationSecret,
      5: userProvider.genderSecret,
    };
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '隐私设置'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => AboutmeSettingItem(
                title: _TypeString[index]!,
                icon: _TypeIcon[index]!,
                hint: SecretsType[getValue[index]!],
                onPressed: () {
                  showDialog<int>(
                    context: context,
                    builder: (context) => SelectDialog(
                      content: '选择谁可以看见',
                      selected: SecretsType,
                      defaultIndex: getValue[index]!,
                    ),
                    barrierColor: Colors.transparent,
                  ).then((value) {
                    if (value != null) setValue[index]!(value);
                    setState(() {});
                  });
                },
              ),
              childCount: _TypeString.length,
            ),
            itemExtent: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/aboutme/components/setting.dart';
import 'package:mybooks/pages/components/select_dialog.dart';

const SecretsType = {0: '所有人禁止', 1: '我关注的', 2: '关注我的', 3: '互相关注', 4: '所有人'};
const NeedToProtectType = {0: '自己的书籍', 1: '生日', 2: '性别', 3: '地区'};
const NeedToProtectTypeIcon = {
  0: Icons.bookmarks,
  1: Icons.cake,
  2: Icons.category_outlined,
  3: Icons.location_on
};

class SecretsSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                title: NeedToProtectType[index]!,
                icon: NeedToProtectTypeIcon[index]!,
                hint: '',
                onPressed: () {
                  showDialog<int>(
                    context: context,
                    builder: (context) => SelectDialog(
                      content: '选择谁可以看见',
                      selected: SecretsType,
                    ),
                    barrierColor: Colors.transparent,
                  ).then((value) {
                    print(SecretsType[value]);
                  });
                },
              ),
              childCount: NeedToProtectType.length,
            ),
            itemExtent: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      ),
    );
  }
}

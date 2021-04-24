import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/aboutme/components/optional_item.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/user_provider.dart';

const GenderType = {0: '未知', 1: '男', 2: '女'};

class GenderSettingPage extends StatefulWidget {
  @override
  _GenderSettingPageState createState() => _GenderSettingPageState();
}

class _GenderSettingPageState extends State<GenderSettingPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUserModel>(context);
    _index = userProvider.gender == null
        ? 0
        : userProvider.gender!
            ? 1
            : 2;
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '性别设置'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => OptionalItem(
                isToggle: index == _index,
                onPressed: () {
                  setState(() => _index = index);
                  bool? gender;
                  switch (_index) {
                    case 0:
                      gender = null;
                      break;
                    case 1:
                      gender = true;
                      break;
                    default:
                      gender = false;
                      break;
                  }
                  Navigator.of(context).pop(gender);
                },
                hintStr: GenderType[index]!,
              ),
              childCount: GenderType.length,
            ),
            itemExtent: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      ),
    );
  }
}

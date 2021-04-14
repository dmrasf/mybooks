import 'package:flutter/material.dart';
import 'package:mybooks/pages/components/icon_button.dart';
import 'package:mybooks/pages/aboutme/components/optional_item.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/theme_provider.dart';

const _Theme = {0: '跟随系统', 1: '夜间', 2: '白天'};

class ThemeSettingPage extends StatefulWidget {
  @override
  _ThemeSettingPageState createState() => _ThemeSettingPageState();
}

class _ThemeSettingPageState extends State<ThemeSettingPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<MyThemeModel>(context);
    _index = themeProvider.isLightTheme == null
        ? 0
        : themeProvider.isLightTheme == false
            ? 1
            : 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: MyIconButton(
          onPressed: () => Navigator.of(context).pop(_Theme[_index]),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('主题设置',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
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
                  switch (_index) {
                    case 0:
                      themeProvider.isLightTheme = null;
                      break;
                    case 1:
                      themeProvider.isLightTheme = false;
                      break;
                    default:
                      themeProvider.isLightTheme = true;
                      break;
                  }
                },
                hintStr: _Theme[index]!,
              ),
              childCount: _Theme.length,
            ),
            itemExtent: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      ),
    );
  }
}

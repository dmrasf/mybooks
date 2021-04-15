import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/aboutme/components/optional_item.dart';
import 'package:mybooks/models/theme_provider.dart';

const ThemeType = {0: '跟随系统', 1: '夜间', 2: '白天'};

class ThemeSettingPage extends StatefulWidget {
  final MyThemeModel themeProvider;
  ThemeSettingPage({Key? key, required this.themeProvider}) : super(key: key);

  @override
  _ThemeSettingPageState createState() => _ThemeSettingPageState();
}

class _ThemeSettingPageState extends State<ThemeSettingPage> {
  late int _index;

  @override
  void initState() {
    _index = widget.themeProvider.isLightTheme == null
        ? 0
        : widget.themeProvider.isLightTheme == false
            ? 1
            : 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '主题设置'),
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
                  switch (_index) {
                    case 0:
                      widget.themeProvider.isLightTheme = null;
                      break;
                    case 1:
                      widget.themeProvider.isLightTheme = false;
                      break;
                    default:
                      widget.themeProvider.isLightTheme = true;
                      break;
                  }
                },
                hintStr: ThemeType[index]!,
              ),
              childCount: ThemeType.length,
            ),
            itemExtent: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      ),
    );
  }
}

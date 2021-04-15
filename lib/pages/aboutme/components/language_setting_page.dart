import 'package:flutter/material.dart';
import 'package:mybooks/pages/aboutme/components/appBar_setting.dart';
import 'package:mybooks/pages/aboutme/components/optional_item.dart';
import 'package:mybooks/models/locale_provider.dart';

const LanguageType = {0: '跟随系统', 1: '汉语', 2: 'English'};

class LanguageSettingPage extends StatefulWidget {
  final MyLocaleModel localeProvider;
  LanguageSettingPage({Key? key, required this.localeProvider})
      : super(key: key);

  @override
  _LanguageSettingPageState createState() => _LanguageSettingPageState();
}

class _LanguageSettingPageState extends State<LanguageSettingPage> {
  late int _index;

  @override
  void initState() {
    _index = widget.localeProvider.locale == null
        ? 0
        : widget.localeProvider.locale == 'en_US'
            ? 2
            : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForSettingPage(context, title: '语言设置'),
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
                      widget.localeProvider.locale = null;
                      break;
                    case 1:
                      widget.localeProvider.locale = 'zh_CN';
                      break;
                    default:
                      widget.localeProvider.locale = 'en_US';
                      break;
                  }
                },
                hintStr: LanguageType[index]!,
              ),
              childCount: LanguageType.length,
            ),
            itemExtent: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/pages/aboutme/components/theme_setting_page.dart';

class AboutmeSetting extends StatefulWidget {
  @override
  _AboutmeSettingState createState() => _AboutmeSettingState();
}

class _AboutmeSettingState extends State<AboutmeSetting> {
  String? _hintTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AboutmeSettingItem(
            icon: Icons.settings,
            title: '资料',
            onPressed: () {},
          ),
          AboutmeSettingItem(
            icon: Icons.tonality,
            title: '主题',
            hint: _hintTheme,
            onPressed: () {
              ChangePage.slideChangePage(context, ThemeSettingPage()).then(
                (value) => setState(() => _hintTheme = value),
              );
            },
          ),
          AboutmeSettingItem(icon: Icons.language, title: '语言', hint: '中文'),
        ],
      ),
    );
  }
}

class AboutmeSettingItem extends StatelessWidget {
  final String title;
  final String? hint;
  final IconData icon;
  final GestureTapCallback? onPressed;
  AboutmeSettingItem({
    Key? key,
    required this.title,
    required this.icon,
    this.hint,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 0.2),
        color: Colors.black.withOpacity(0.3),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5),
            Icon(icon, size: 15),
            SizedBox(width: 15),
            Text(title, style: TextStyle(fontWeight: FontWeight.w800)),
            Spacer(),
            hint == null
                ? Icon(Icons.arrow_forward_ios,
                    size: 10, color: Colors.white.withOpacity(0.6))
                : Text(hint!,
                    style: TextStyle(color: Colors.white.withOpacity(0.6))),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

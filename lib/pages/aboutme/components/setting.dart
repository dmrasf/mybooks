import 'package:flutter/material.dart';
import 'package:mybooks/models/locale_provider.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/pages/aboutme/components/profile_setting_page.dart';
import 'package:mybooks/pages/aboutme/components/theme_setting_page.dart';
import 'package:mybooks/pages/aboutme/components/language_setting_page.dart';
import 'package:mybooks/utils/location.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/theme_provider.dart';

class AboutmeSetting extends StatefulWidget {
  @override
  _AboutmeSettingState createState() => _AboutmeSettingState();
}

class _AboutmeSettingState extends State<AboutmeSetting> {
  int? _hintTheme;
  int? _hintLocale;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<MyThemeModel>(context);
    final localeProvider = Provider.of<MyLocaleModel>(context);
    _hintTheme = themeProvider.isLightTheme == null
        ? 0
        : themeProvider.isLightTheme!
            ? 2
            : 1;
    _hintLocale = localeProvider.locale == null
        ? 0
        : localeProvider.locale == 'en_US'
            ? 2
            : 1;
    return Container(
      child: Column(
        children: [
          AboutmeSettingItem(
            icon: Icons.settings,
            title: MBLocalizations.of(context).profile,
            onPressed: () => ChangePage.slideChangePage(
              context,
              ProfileSettingPage(),
            ),
          ),
          AboutmeSettingItem(
            icon: Icons.tonality,
            title: '主题',
            hint: ThemeType[_hintTheme],
            onPressed: () => ChangePage.slideChangePage(
              context,
              ThemeSettingPage(themeProvider: themeProvider),
            ),
          ),
          AboutmeSettingItem(
            icon: Icons.language,
            title: '语言',
            hint: LanguageType[_hintLocale],
            onPressed: () => ChangePage.slideChangePage(
              context,
              LanguageSettingPage(localeProvider: localeProvider),
            ),
          ),
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
        color: Theme.of(context).primaryColor.withOpacity(0.3),
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

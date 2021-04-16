import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybooks/models/locale_provider.dart';
import 'package:mybooks/utils/change_page.dart';
import 'package:mybooks/pages/aboutme/components/profile_setting_page.dart';
import 'package:mybooks/pages/aboutme/components/theme_setting_page.dart';
import 'package:mybooks/pages/aboutme/components/language_setting_page.dart';
import 'package:mybooks/utils/location.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/theme_provider.dart';

class AboutmeSetting extends StatelessWidget {
  final VoidCallback? updateState;
  AboutmeSetting({Key? key, this.updateState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<MyThemeModel>(context);
    final localeProvider = Provider.of<MyLocaleModel>(context);
    int hintTheme = themeProvider.isLightTheme == null
        ? 0
        : themeProvider.isLightTheme!
            ? 2
            : 1;
    int hintLocale = localeProvider.locale == null
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
            ).then((value) {
              if (updateState != null) updateState!();
            }),
          ),
          AboutmeSettingItem(
            icon: Icons.tonality,
            title: '主题',
            hint: ThemeType[hintTheme],
            onPressed: () => ChangePage.slideChangePage(
              context,
              ThemeSettingPage(themeProvider: themeProvider),
            ),
          ),
          AboutmeSettingItem(
            icon: Icons.language,
            title: '语言',
            hint: LanguageType[hintLocale],
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
  final Color? titleColor;
  final String? hint;
  final IconData icon;
  final GestureTapCallback? onPressed;
  AboutmeSettingItem({
    Key? key,
    required this.title,
    this.titleColor,
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
        color: Theme.of(context).primaryColor,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5),
            Icon(icon, size: 15),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: titleColor,
              ),
            ),
            Spacer(),
            hint == null
                ? Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                    color: Theme.of(context).buttonColor.withOpacity(0.6),
                  )
                : Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4,
                    ),
                    child: Text(
                      hint!,
                      style: GoogleFonts.jua(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).buttonColor.withOpacity(0.4),
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

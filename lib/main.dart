import 'package:flutter/material.dart';
import 'package:mybooks/pages/home/home_page.dart';
import 'package:mybooks/utils/init.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/theme_provider.dart';
import 'package:mybooks/models/locale_provider.dart';
import 'package:mybooks/utils/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => Init.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MyThemeModel()),
        ChangeNotifierProvider.value(value: MyLocaleModel()),
      ],
      child: Consumer2<MyThemeModel, MyLocaleModel>(
        builder: (context, theme, locale, child) => MaterialApp(
          title: 'mybooks',
          debugShowCheckedModeBanner: false,
          theme: theme.isLightTheme ? MyTheme.lightTheme : MyTheme.darkTheme,
          darkTheme: MyTheme.darkTheme,
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('zh', 'CN'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: HomePage(),
        ),
      ),
    );
  }
}

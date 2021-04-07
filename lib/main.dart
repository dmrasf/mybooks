import 'package:flutter/material.dart';
import 'package:mybooks/pages/home/home_page.dart';
import 'package:mybooks/utils/init.dart';
import 'package:provider/provider.dart';
import 'package:mybooks/models/theme_provider.dart';
import 'package:mybooks/models/locale_provider.dart';
import 'package:mybooks/utils/theme.dart';
import 'package:mybooks/utils/location.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Init.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MyThemeModel()),
        ChangeNotifierProvider.value(value: MyLocaleModel()),
      ],
      child: Consumer2<MyThemeModel, MyLocaleModel>(
        builder: (context, myTheme, myLocale, child) => MaterialApp(
          title: 'mybooks',
          debugShowCheckedModeBanner: false,
          theme: myTheme.isLightTheme ? MyTheme.lightTheme : MyTheme.darkTheme,
          darkTheme: MyTheme.darkTheme,
          locale: myLocale.getLocale(),
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('zh', 'CN'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            MBLocalizationsDelegate(),
          ],
          localeResolutionCallback: (
            Locale? locale,
            Iterable<Locale>? supportedLocales,
          ) {
            if (myLocale.getLocale() != null) {
              return myLocale.getLocale();
            } else {
              Locale _locale = Locale('zh', 'CN');
              if (supportedLocales != null && locale != null) {
                if (supportedLocales.contains(locale)) _locale = locale;
              }
              return _locale;
            }
          },
          home: HomePage(),
        ),
      ),
    );
  }
}

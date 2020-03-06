import 'package:flutter/material.dart';
import 'package:flutter_buj_app/util/router.dart' as router;
import 'package:flutter_buj_app/util/routing_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_localizations/i18n_localizations_delegate.dart';

void main() => runApp(BujApp());


class BujApp extends StatelessWidget {
  final I18nLocalizationsDelegate i18n = I18nLocalizationsDelegate(
      supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
      pathFile: 'assets/i18n'
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BUJ',
        onGenerateRoute: router.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePageRoute,
        supportedLocales: i18n.supportedLocales,
        localizationsDelegates: [
          i18n,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (Locale locale, supportedLocales) {
          return i18n.localeResolutionCallback(locale);
        },
    );
  }
}

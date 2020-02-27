import 'package:flutter/material.dart';
import 'package:flutter_buj_app/util/router.dart' as router;
import 'package:flutter_buj_app/util/routing_constants.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(BujApp());


class BujApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
      useCountryCode: false,
      fallbackFile: 'en',
      path: 'assets/i18n',
      forcedLocale: new Locale('fr'));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BUJ',
        onGenerateRoute: router.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePageRoute,
        localizationsDelegates: [
          flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
    );
  }
}

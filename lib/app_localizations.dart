import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  final List<Locale> supportedLocales;
  final String pathFile;
  Map<dynamic, dynamic> localizedMap;

  AppLocalizations(this.locale, this.supportedLocales, this.pathFile);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async {
    // Load the language JSON file from the "assets/i18n" folder
    String jsonString =
    await rootBundle.loadString('$pathFile/${locale.languageCode}.json');
    localizedMap = json.decode(jsonString);

    return true;
  }

  static Locale localeResolutionCallback(Locale locale, supportedLocales) {
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    // If the locale of the device is not supported, use the first one
    // from the list (English, in this case).
    return supportedLocales.first;
  }

  // This method will be called from every widget which needs a localized text
  static String translate(BuildContext context, String key) {
    return _decodeFromMap(Localizations
        .of<AppLocalizations>(context, AppLocalizations)
        .localizedMap, key);
  }

  addLocale(Locale locale) {
    supportedLocales.add(locale);
  }

  static String _decodeFromMap(Map<dynamic, dynamic> decodedMap,
      final String key) {
    final Map<dynamic, dynamic> subMap = _calculateSubmap(decodedMap, key);
    final String lastKeyPart = key
        .split(".")
        .last;
    return subMap[lastKeyPart];
  }

  static Map<dynamic, dynamic> _calculateSubmap(
      Map<dynamic, dynamic> decodedMap, final String translationKey) {
    final List<String> translationKeySplitted = translationKey.split(".");
    translationKeySplitted.removeLast();
    translationKeySplitted.forEach((listKey) =>
    decodedMap =
    decodedMap != null && decodedMap[listKey] != null
        ? decodedMap[listKey]
        : new Map());
    return decodedMap;
  }

}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final List<Locale> supportedLocales;
  final String pathFile;
  static AppLocalizations localizations;

  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  AppLocalizationsDelegate({this.supportedLocales, this.pathFile});

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return _languageCodeSuppotedLocales().contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    localizations = AppLocalizations(locale, supportedLocales, pathFile);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;

  localeResolutionCallback(Locale locale) {
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    // If the locale of the device is not supported, use the first one
    // from the list (English, in this case).
    return supportedLocales.first;
  }

  _languageCodeSuppotedLocales() {
    return supportedLocales.map((locale) => locale.languageCode);
  }
}
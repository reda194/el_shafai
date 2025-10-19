import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('lib/core/localization/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Helper method for easy access
  String get(String key) => translate(key);

  // Common translations
  String get appName => get('app_name');
  String get welcome => get('welcome');
  String get home => get('home');
  String get appointments => get('appointments');
  String get doctors => get('doctors');
  String get chat => get('chat');
  String get profile => get('profile');
  String get settings => get('settings');
  String get notifications => get('notifications');
  String get search => get('search');
  String get filter => get('filter');
  String get bookAppointment => get('book_appointment');
  String get login => get('login');
  String get register => get('register');
  String get logout => get('logout');
  String get save => get('save');
  String get cancel => get('cancel');
  String get confirm => get('confirm');
  String get skip => get('skip');
  String get next => get('next');
  String get previous => get('previous');
  String get done => get('done');
  String get loading => get('loading');
  String get error => get('error');
  String get success => get('success');
  String get retry => get('retry');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

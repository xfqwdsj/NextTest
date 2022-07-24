// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `NextTest`
  String get appName {
    return Intl.message(
      'NextTest',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `主页`
  String get mainPageTitle {
    return Intl.message(
      '主页',
      name: 'mainPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `题组选择`
  String get selectingPageTitle {
    return Intl.message(
      '题组选择',
      name: 'selectingPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `作者：`
  String get selectingPageItemAuthorPrefix {
    return Intl.message(
      '作者：',
      name: 'selectingPageItemAuthorPrefix',
      desc: '',
      args: [],
    );
  }

  /// `测试`
  String get testingPageTitle {
    return Intl.message(
      '测试',
      name: 'testingPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `正确`
  String get testingPageCorrectChipLabel {
    return Intl.message(
      '正确',
      name: 'testingPageCorrectChipLabel',
      desc: '',
      args: [],
    );
  }

  /// `错误`
  String get testingPageWrongChipLabel {
    return Intl.message(
      '错误',
      name: 'testingPageWrongChipLabel',
      desc: '',
      args: [],
    );
  }

  /// `待定`
  String get testingPagePendingChipLabel {
    return Intl.message(
      '待定',
      name: 'testingPagePendingChipLabel',
      desc: '',
      args: [],
    );
  }

  /// `无人区`
  String get notFoundPageTitle {
    return Intl.message(
      '无人区',
      name: 'notFoundPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `没有找到该页面...😥`
  String get notFoundPageContent {
    return Intl.message(
      '没有找到该页面...😥',
      name: 'notFoundPageContent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

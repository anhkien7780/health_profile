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

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Health Profile`
  String get appName {
    return Intl.message('Health Profile', name: 'appName', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Email`
  String get emailTitle {
    return Intl.message('Email', name: 'emailTitle', desc: '', args: []);
  }

  /// `Enter your email`
  String get emailHint {
    return Intl.message(
      'Enter your email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordTitle {
    return Intl.message('Password', name: 'passwordTitle', desc: '', args: []);
  }

  /// `Enter your password`
  String get passwordHint {
    return Intl.message(
      'Enter your password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Register new account`
  String get registerAccount {
    return Intl.message(
      'Register new account',
      name: 'registerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forgetPassword {
    return Intl.message(
      'Forget password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Quickly look up medical records and schedule appointments`
  String get onboardingFirstHeadline {
    return Intl.message(
      'Quickly look up medical records and schedule appointments',
      name: 'onboardingFirstHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Clinical disease diagnosis tool`
  String get onBoardingSecondHeadline {
    return Intl.message(
      'Clinical disease diagnosis tool',
      name: 'onBoardingSecondHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Make medical visits no longer about waiting or complicated procedures`
  String get onBoardingThirdHeadline {
    return Intl.message(
      'Make medical visits no longer about waiting or complicated procedures',
      name: 'onBoardingThirdHeadline',
      desc: '',
      args: [],
    );
  }

  /// `The app helps you access your medical records as soon as results are available. Book doctor appointments quickly and tailored to your needs.`
  String get onBoardingFirstDetail {
    return Intl.message(
      'The app helps you access your medical records as soon as results are available. Book doctor appointments quickly and tailored to your needs.',
      name: 'onBoardingFirstDetail',
      desc: '',
      args: [],
    );
  }

  /// `Integrated disease diagnosis tool that uses specialized medical knowledge to identify clinical symptoms.`
  String get onBoardingSecondDetail {
    return Intl.message(
      'Integrated disease diagnosis tool that uses specialized medical knowledge to identify clinical symptoms.',
      name: 'onBoardingSecondDetail',
      desc: '',
      args: [],
    );
  }

  /// `Minimalist and user-friendly design.`
  String get onBoardingThirdDetail {
    return Intl.message(
      'Minimalist and user-friendly design.',
      name: 'onBoardingThirdDetail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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

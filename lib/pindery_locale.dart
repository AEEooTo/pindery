/// pindery_locale.dart
/// contains the code for Pindery's localization

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
// import 'package:flutter_localizations/flutter_localizations.dart';

class PinderyLocalizations {
  PinderyLocalizations(this.locale);

  final Locale locale;

  static PinderyLocalizations of(BuildContext context) {
    return Localizations.of<PinderyLocalizations>(context, PinderyLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Pindery',
      'new_party': 'New party',
    },
    'it': {
      'title': 'Pindery',
      'new_party': 'Nuova festa',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
}

class PinderyLocalizationsDelegate extends LocalizationsDelegate<PinderyLocalizations> {
  const PinderyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<PinderyLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return new SynchronousFuture<PinderyLocalizations>(new PinderyLocalizations(locale));
  }

  @override
  bool shouldReload(PinderyLocalizationsDelegate old) => false;
}
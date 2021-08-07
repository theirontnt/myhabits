import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension underscore on Locale {
  String get code {
    if (this.countryCode != null) {
      return this.languageCode.toLowerCase() + "_" + this.countryCode!.toUpperCase();
    }
    return this.languageCode.toLowerCase();
  }
}

class Language {
  Language(this.locale);

  final Locale locale;
  static Language of(BuildContext context) => Localizations.of<Language>(context, Language)!;

  static Locale? fromCode(String code) {
    if (code.length == 5) {
      return Locale(code.substring(0, 2), code.substring(3));
    }
  }

  static const List<Locale> supportedLanguages = [
    const Locale("mn", "MN"),
    const Locale("en", "US"),
  ];

  static const List<String> supportedLanguagesNames = [
    "Монгол хэл (Mongolia)",
    "English (United States)",
  ];

  static int supportedLanguagesCount = supportedLanguages.length;

  late Map<String, String> _localizedValues;

  Future<void> load() async {
    String jsonStringValues = await rootBundle.loadString('assets/lang/${locale.code}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String get(String key, {replace}) {
    String value = _localizedValues[key] ?? key;
    if (replace is String) {
      return value.replaceAll("&", replace);
    } else if (replace is List<String>) {
      for (int i = 0; i < replace.length; i++) {
        value = value.replaceAll("&$i", replace[i]);
      }
    }
    return value;
  }

  static printMissingKeys() async {
    final Map<String, Map<String, String>> languages = {};
    for (Locale locale in supportedLanguages) {
      String value = await rootBundle.loadString('assets/lang/${locale.code}.json');

      languages[locale.code] = (json.decode(value) as Map<String, dynamic>).map((key, value) => MapEntry(key, value.toString()));
    }
    final Set<String> keys = new Set<String>();
    languages.keys.forEach((key) {
      keys.addAll(languages[key]!.keys);
    });

    languages.keys.forEach((key) {
      final Iterable<String> missingKeys = keys.where((element) => !languages[key]!.keys.contains(element));
      if (missingKeys.length == 0) {
        print("[Gegee Language Service] $key has no missing keys");
      } else {
        print("[Gegee Language Service] $key has ${missingKeys.length} missing keys");
        missingKeys.forEach((element) {
          print("$element");
        });
      }
      print("-------------------");
    });
  }

  static const LocalizationsDelegate<Language> delegate = _GegeeGuitarLanguageLocalizationDelegate();
}

class _GegeeGuitarLanguageLocalizationDelegate extends LocalizationsDelegate<Language> {
  const _GegeeGuitarLanguageLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return Language.supportedLanguages.contains(locale);
  }

  @override
  Future<Language> load(Locale locale) async {
    Language localization = new Language(Language.supportedLanguages.contains(locale) ? locale : Language.supportedLanguages[1]);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Language> old) => false;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('ar', '')); // Default to Arabic

  void setLanguage(String languageCode) {
    state = Locale(languageCode, '');
  }

  void toggleLanguage() {
    if (state.languageCode == 'ar') {
      state = const Locale('en', '');
    } else {
      state = const Locale('ar', '');
    }
  }

  bool get isArabic => state.languageCode == 'ar';
  bool get isEnglish => state.languageCode == 'en';

  String get currentLanguageName {
    switch (state.languageCode) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
      default:
        return 'العربية';
    }
  }
}

import 'dart:ui';

enum Language { vi, en }

extension LanguageExtension on Language {
  Locale get local {
    switch (this) {
      case Language.vi:
        return const Locale("vi");
      case Language.en:
        return const Locale("en");
    }
  }
}

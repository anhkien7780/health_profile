import 'package:health_profile/generated/l10n.dart';

class TextValidator {
  TextValidator._();

  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.emailNotEmpty;
    }
    if (!_emailRegex.hasMatch(value)) {
      return S.current.invalidEmailFormat;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.passwordNotEmpty;
    }
    if (value.length < 6) {
      return S.current.passwordMinLength;
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.fullNameNotEmpty;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (password != confirmPassword) {
      return S.current.passwordNotMatch;
    }
    return null;
  }
}

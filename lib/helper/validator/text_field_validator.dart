import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utils/app_strings/app_strings.dart';

class TextFieldValidator {
  static String? Function(String?) required({required String errorText}) {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return errorText.tr;
      }

      return null;
    };
  }

  static String? Function(String?) email() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.emailRequired.tr;
      }

      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

      if (!emailRegex.hasMatch(trimmed)) {
        return AppStrings.validEmailAddress.tr;
      }

      return null;
    };
  }

  static String? Function(String?) password() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.passwordRequired.tr;
      }

      if (trimmed.length < 8) {
        return AppStrings.passwordMin8.tr;
      }

      if (!RegExp(r'[A-Z]').hasMatch(trimmed)) {
        return AppStrings.uppercaseRequired.tr;
      }

      if (!RegExp(r'[0-9]').hasMatch(trimmed)) {
        return AppStrings.numberRequired.tr;
      }

      return null;
    };
  }

  static String? Function(String?) confirmPassword(
    TextEditingController originalController,
  ) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      final originalPassword = originalController.text.trim();

      if (trimmed.isEmpty) {
        return AppStrings.confirmPasswordRequired.tr;
      }

      if (originalPassword.isEmpty) {
        return AppStrings.enterPasswordFirst.tr;
      }

      if (trimmed != originalPassword) {
        return AppStrings.passwordsDoNotMatch.tr;
      }

      return null;
    };
  }

  static String? Function(String?) otp() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.otpRequired.tr;
      }

      if (trimmed.length != 6) {
        return AppStrings.otpMustBe6Digits.tr;
      }

      if (!RegExp(r'^[0-9]{6}$').hasMatch(trimmed)) {
        return AppStrings.otpNumbersOnly.tr;
      }

      return null;
    };
  }

  static String? Function(String?) requiredField({
    String label = AppStrings.fieldRequired,
  }) {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return '${label.tr} ${'required'.tr}';
      }

      return null;
    };
  }

  static String? Function(String?) website() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.websiteUrlRequired.tr;
      }

      final urlPattern = RegExp(
        r'^(https?:\/\/)([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(\/[^\s]*)?$',
        caseSensitive: false,
      );

      if (!urlPattern.hasMatch(trimmed)) {
        return AppStrings.validWebsiteUrl.tr;
      }

      return null;
    };
  }

  static String? Function(String?) name() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.nameRequired.tr;
      }

      final nameRegex = RegExp(r'^[a-zA-Z\s.]{2,}$');

      if (!nameRegex.hasMatch(trimmed)) {
        return AppStrings.validName.tr;
      }

      return null;
    };
  }

  static String? Function(String?) phone() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.phoneNumberRequired.tr;
      }

      final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

      if (!phoneRegex.hasMatch(trimmed)) {
        return AppStrings.validPhoneNumber.tr;
      }

      return null;
    };
  }

  static String? Function(String?) username() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.usernameRequired.tr;
      }

      final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

      if (!usernameRegex.hasMatch(trimmed)) {
        return AppStrings.usernameInvalidLength.tr;
      }

      return null;
    };
  }

  static String? Function(String?) number({
    String label = AppStrings.valueRequired,
  }) {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return '${label.tr} ${'required'.tr}';
      }

      if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(trimmed)) {
        return AppStrings.validNumber.tr;
      }

      return null;
    };
  }

  static String? Function(String?) address() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.addressRequired.tr;
      }

      if (trimmed.length < 5) {
        return AppStrings.validAddress.tr;
      }

      return null;
    };
  }

  static String? Function(String?) city() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.cityRequired.tr;
      }

      if (trimmed.length < 2) {
        return AppStrings.validCityName.tr;
      }

      return null;
    };
  }

  static String? Function(String?) zipcode() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.zipcodeRequired.tr;
      }

      if (!RegExp(r'^\d{4,10}$').hasMatch(trimmed)) {
        return AppStrings.validZipcode.tr;
      }

      return null;
    };
  }

  static String? Function(String?) country() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.countryRequired.tr;
      }

      if (trimmed.length < 2) {
        return AppStrings.validCountryName.tr;
      }

      return null;
    };
  }

  static String? Function(String?) description({int minLength = 10}) {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.descriptionRequired.tr;
      }

      if (trimmed.length < minLength) {
        return AppStrings.descriptionMinLength.trParams({
          'min': minLength.toString(),
        });
      }

      return null;
    };
  }

  static String? Function(String?) postalCode() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.postalCodeRequired.tr;
      }

      if (!RegExp(r'^[0-9]{4,10}$').hasMatch(trimmed)) {
        return AppStrings.validPostalCode.tr;
      }

      return null;
    };
  }

  static String? Function(String?) dateOfBirth() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.dateOfBirthRequired.tr;
      }

      if (!RegExp(
        r'^(0[1-9]|[12][0-9]|3[01])[-/](0[1-9]|1[0-2])[-/](\d{4})$',
      ).hasMatch(trimmed)) {
        return AppStrings.validDateOfBirth.tr;
      }

      final dateParts = trimmed.split(RegExp(r'[-/ ]'));

      final day = int.tryParse(dateParts[0]);
      final month = int.tryParse(dateParts[1]);
      final year = int.tryParse(dateParts[2]);

      if (day == null || month == null || year == null) {
        return AppStrings.invalidDateFormat.tr;
      }

      try {
        final date = DateTime(year, month, day);

        if (date.isAfter(DateTime.now())) {
          return AppStrings.dateOfBirthFuture.tr;
        }
      } catch (_) {
        return AppStrings.invalidDateOfBirth.tr;
      }

      return null;
    };
  }

  static String? Function(String?) gender() {
    return (value) {
      final trimmed = value?.trim() ?? '';

      if (trimmed.isEmpty) {
        return AppStrings.genderRequired.tr;
      }

      if (!['male', 'female', 'other'].contains(trimmed.toLowerCase())) {
        return AppStrings.validGender.tr;
      }

      return null;
    };
  }
}

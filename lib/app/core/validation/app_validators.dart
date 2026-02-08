
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/validation/app_regex.dart';
import 'package:flutter/material.dart';

class AppValidators {
  /// Validate email field
  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return "emailRequired".tr();
    } else if (!AppRegex.isEmailValid(value.trim())) {
      return "emailInvalid".tr();
    }
    return null;
  }

  /// Validate password field
  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "passwordRequired".tr();
    } else if (!AppRegex.hasMinLength(value)) {
      return "passwordMinLength".tr();
    } else if (!AppRegex.hasUpperCase(value)) {
      return "passwordUpperCase".tr();
    } else if (!AppRegex.hasLowerCase(value)) {
      return "passwordLowerCase".tr();
    } else if (!AppRegex.hasNumber(value)) {
      return "passwordNumber".tr();
    } else if (!AppRegex.hasSpecialCharacter(value)) {
      return "passwordSpecialChar".tr();
    }
    return null;
  }

  /// Validate confirm password field
  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return "confirmPasswordRequired".tr();
    } else if (value != originalPassword) {
      return "passwordNotMatch".tr();
    }

    return null;
  }

  /// Validate name field
  static String? validateUserName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "userNameRequired".tr();
    }
    return null;
  }

  /// Validate phone field
  static String? validateNumberPhone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "phoneNumberRequired".tr();
    }
    return null;
  }

  static String? validateFirstName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "firstNameRequired".tr();
    }
    return null;
  }

  static String? validateLastName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "lastNameRequired".tr();
    }
    return null;
  }
}

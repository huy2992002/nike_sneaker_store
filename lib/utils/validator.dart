import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';

class Validator {
  /// Check that [value] cannot be empty with a [context] that prints an error equal with l10n
  static String? validatorRequired(BuildContext context, String? value) {
    if ((value ?? '').isEmpty) {
      return AppLocalizations.of(context).fieldIsRequired;
    }
    return null;
  }

  /// Check that [value] cannot be empty and the email format is correct
  /// with a [context] that prints an error equal with l10n
  static String? validatorEmail(BuildContext context, String? value) {
    if ((value ?? '').isEmpty) {
      return AppLocalizations.of(context).fieldIsRequired;
    }

    final regex = RegExp(NSConstants.emailPattern);
    if (!regex.hasMatch(value ?? '')) {
      return AppLocalizations.of(context).validEmailAddress;
    }
    return null;
  }

  /// Check that [value] cannot be empty and has a length of 6 characters 
  /// with a [context] that prints an error equal with l10n
  static String? validatorPassword(BuildContext context, String? value) {
    if ((value ?? '').isEmpty) {
      return AppLocalizations.of(context).fieldIsRequired;
    }
    if ((value ?? '').length < 6) {
      return AppLocalizations.of(context).passwordLeast6;
    }
    return null;
  }

  /// Check that [value] cannot be empty, has a length of 6 characters 
  /// and equal with [password]
  /// with a [context] that prints an error equal with l10n
  static String? validatorConfirmPassword(
    BuildContext context,
    String? value,
    String password,
  ) {
    if ((value ?? '').isEmpty) {
      return AppLocalizations.of(context).fieldIsRequired;
    }
    if ((value ?? '').length < 6) {
      return AppLocalizations.of(context).passwordLeast6;
    }
    if (value != password) {
      return AppLocalizations.of(context).confirmPasswordNotMatch;
    }
    return null;
  }

  static String? validatorPhoneNumber(BuildContext context, String? value) {
    if ((value ?? '').isEmpty) {
      return AppLocalizations.of(context).fieldIsRequired;
    }

    final regex = RegExp(NSConstants.phonePattern);
    if (!regex.hasMatch(value ?? '')) {
      return AppLocalizations.of(context).validPhoneNumber;
    }
    return null;
  }
}

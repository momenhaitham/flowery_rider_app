
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flutter/material.dart';

String getException( Exception? exception) {
  String error = '';
  switch (exception) {
    case ConnectionError():
      error = AppLocale.connectionFailed.tr();
      break;
    case ServerError():
      error = exception.message ?? '';
      break;
  }
  return error;
}
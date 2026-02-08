
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flutter/material.dart';

String getException(BuildContext context, Exception? exception) {
  String error = '';
  switch (exception) {
    case ConnectionError():
      error = "connectionFailed".tr();
      break;
    case ServerError():
      error = exception.message ?? '';
      break;
  }
  return error;
}
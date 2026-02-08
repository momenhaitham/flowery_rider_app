
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/read_and_write_locale_usecase.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {

  String? currentLocale;
  ReadAndWriteLocaleUsecase readAndWriteLocaleUsecase;
  AppProvider(this.readAndWriteLocaleUsecase);

  Future<void> changeLocale(String locale) async {
    currentLocale=locale;
    await readAndWriteLocaleUsecase.invokeSetCurrentLocale(locale);
    notifyListeners();
  }

  Future<void> getCurrentLocale() async {
    currentLocale = await readAndWriteLocaleUsecase.invokeGetCurrentLocale();
    notifyListeners();
  }

}
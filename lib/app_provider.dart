
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/read_and_write_locale_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppProvider extends ChangeNotifier {

  String? currentLocale;
  ReadAndWriteLocaleUsecase readAndWriteLocaleUsecase;
  AppProvider(this.readAndWriteLocaleUsecase);

  Future<void> changeLocale(BuildContext context,String locale) async {
    currentLocale=locale;
    if(context.mounted){
      context.setLocale(Locale(currentLocale!));
    }
    await readAndWriteLocaleUsecase.invokeSetCurrentLocale(locale);
    notifyListeners();
  }

  Future<void> getCurrentLocale(BuildContext context) async {
    currentLocale = await readAndWriteLocaleUsecase.invokeGetCurrentLocale();
    if(context.mounted){
      context.setLocale(Locale(currentLocale!));
    }
    
    notifyListeners();
  }

}
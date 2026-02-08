
import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/core/consts/app_consts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/storage_data_source_contract.dart';

@Injectable(as: StorageDataSourceContract)
class StorageLocalDataSourceImpl extends StorageDataSourceContract {
  final FlutterSecureStorage _storage;
  final SharedPreferences _sharedPreferences;

  StorageLocalDataSourceImpl(this._storage, this._sharedPreferences);

  @override
  Future<BaseResponse<bool>> addRememberMe(bool rememberMe) => executeApi(
    () => _sharedPreferences.setBool(AppConsts.rememberMeKey, rememberMe),
  );

  @override
  Future<BaseResponse<bool>> addToken(String token) => executeApi(() async {
    await _storage.write(key: AppConsts.tokenKey, value: token);
    return true;
  });

  @override
  bool? getRememberMe() {
    final result = _sharedPreferences.getBool(AppConsts.rememberMeKey);
    return result;
  }

  @override
  Future<String?> getToken() async {
    final token = await _storage.read(key: AppConsts.tokenKey);
    return token;
  }

  @override
  Future<BaseResponse<bool>> clearToken() => executeApi(() async {
    await _storage.deleteAll();
    return true;
  });

  @override
  Future<BaseResponse<bool>> clearRememberMe() => executeApi(() async {
    await _sharedPreferences.remove(AppConsts.rememberMeKey);
    return true;
  });
  
  @override
  Future<String> getCurrentLocale()async {
    SharedPreferences share= await SharedPreferences.getInstance();
    var currentLocale = share.getString(AppConsts.languageKey) ?? 'en';
    return currentLocale;
  }
  
  @override
  Future<void> setCurrentLocale(String locale)async {
    SharedPreferences share= await SharedPreferences.getInstance();
    await share.setString(AppConsts.languageKey, locale);
  }
}

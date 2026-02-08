import '../../base_response/base_response.dart';

abstract class StorageDataSourceContract {
  Future<String?> getToken();

  Future<BaseResponse<bool>> addToken(String token);

  Future<BaseResponse<bool>> addRememberMe(bool rememberMe);

  bool? getRememberMe();

  Future<BaseResponse<bool>> clearToken();

  Future<BaseResponse<bool>> clearRememberMe();

  Future<String> getCurrentLocale();
  
  Future<void> setCurrentLocale(String locale);
}

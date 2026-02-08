import 'package:flowery_rider_app/app/config/base_response/base_response.dart';

abstract class TokenRepoContract {
  Future<String?> getToken();
  Future<BaseResponse<bool>> clearToken();
  bool? getRememberMe();
}

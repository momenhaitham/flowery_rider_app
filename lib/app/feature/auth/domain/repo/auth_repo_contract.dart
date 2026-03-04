import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/model/auth_model.dart';

abstract class AuthRepoContract {
  // get auth data
  Future<void> getAuthData();

  Future<BaseResponse<AuthModel>> login(String email, String password,
      {bool rememberMe = false});
}

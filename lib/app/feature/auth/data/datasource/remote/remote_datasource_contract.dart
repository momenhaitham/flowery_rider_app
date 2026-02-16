import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/data/model/auth_response.dart';

abstract class AuthRemoteDatasourceContract {
  Future<BaseResponse<AuthDto>> login(String email, String password);
}

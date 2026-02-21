import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import '../../../config/base_response/base_response.dart';
abstract class ProfileDataSourceContract {
  Future<BaseResponse<DriverAuthResponse>> getProfile();
}

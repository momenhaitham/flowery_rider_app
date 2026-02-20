import '../../../config/base_response/base_response.dart';
import 'model/driver_entity.dart';
abstract class ProfileRepoContract {
  Future<BaseResponse<DriverEntity>> getProfile();
}

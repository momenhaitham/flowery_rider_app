import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import '../../../config/base_response/base_response.dart';
abstract class ApplyDriverRepoContract {
  Future<BaseResponse<String>> applyDriver(ApplyDriverRequest request);

}
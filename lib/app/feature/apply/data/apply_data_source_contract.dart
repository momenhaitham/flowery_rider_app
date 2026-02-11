import '../../../config/base_response/base_response.dart';
import '../domain/request/apply_driver_request.dart';
import 'model/apply_driver_response.dart';

abstract class ApplyDataSourceContract {
 Future<BaseResponse<ApplyDriverResponse>> applyDriver(ApplyDriverRequest request);
}
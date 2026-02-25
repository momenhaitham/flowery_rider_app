import '../../../config/base_response/base_response.dart';
import '../domain/request/apply_driver_request.dart';
import 'model/driver_auth_response.dart';

abstract class ApplyDriverDataSourceContract {
 Future<BaseResponse<DriverAuthResponse>> applyDriver(ApplyDriverRequest request);
}
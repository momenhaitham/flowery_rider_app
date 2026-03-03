import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/api/apply_api_client.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:injectable/injectable.dart';

import '../data/apply_driver_data_source_contract.dart';
@Injectable(as: ApplyDriverDataSourceContract)
class ApplyDriverOnlineDataSourceImpl implements ApplyDriverDataSourceContract {
  final ApplyApiClient applyApiClient;

  ApplyDriverOnlineDataSourceImpl(this.applyApiClient);

  @override
  Future<BaseResponse<DriverAuthResponse>> applyDriver(ApplyDriverRequest request) =>executeApi(
    () => applyApiClient.applyDriver(request),
  );
}

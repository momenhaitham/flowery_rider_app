import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply/api/apply_api_client.dart';
import 'package:flowery_rider_app/app/feature/apply/data/model/apply_driver_response.dart';
import 'package:flowery_rider_app/app/feature/apply/domain/request/apply_driver_request.dart';
import 'package:injectable/injectable.dart';

import '../data/apply_data_source_contract.dart';
@Injectable(as: ApplyDataSourceContract)
class ApplyDriverOnlineDataSourceImpl implements ApplyDataSourceContract {
  final ApplyApiClient applyApiClient;

  ApplyDriverOnlineDataSourceImpl(this.applyApiClient);

  @override
  Future<BaseResponse<ApplyDriverResponse>> applyDriver(ApplyDriverRequest request) =>executeApi(
    () => applyApiClient.applyDriver(request),
  );
}

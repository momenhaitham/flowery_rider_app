import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/api/vehicle_api_client.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/vehicle_data_source_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: VehicleDataSourceContract)
class VehicleOnlineDataSourceImpl  extends VehicleDataSourceContract{
  final VehicleApiClient _apiClient;
  VehicleOnlineDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<VehiclesResponse>> getAllVehicles() =>executeApi(() => _apiClient.getAllVehicles(),);
}
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';

abstract class VehicleDataSourceContract {
  Future<BaseResponse<VehiclesResponse>> getAllVehicles();
}
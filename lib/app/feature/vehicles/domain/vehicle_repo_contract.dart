import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';

import '../../../config/base_response/base_response.dart';


abstract class VehicleRepoContract {
  Future<BaseResponse<List<VehicleEntity?>>> getAllVehicles();

}
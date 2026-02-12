import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/vehicle_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/vehicle_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: VehicleRepoContract)
class VehicleRepoImpl  extends VehicleRepoContract{
  final VehicleDataSourceContract _remoteDataSource;
  VehicleRepoImpl(this._remoteDataSource);
  @override
  Future<BaseResponse<List<VehicleEntity>>> getAllVehicles()async {
final response = await _remoteDataSource.getAllVehicles();
switch (response) {
  case SuccessResponse<VehiclesResponse>():
   return SuccessResponse(data: response.data.toVehicleEntity()??[]);
  case ErrorResponse<VehiclesResponse>():
   return ErrorResponse(error: response.error);
}
  }
}
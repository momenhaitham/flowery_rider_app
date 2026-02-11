import 'package:flowery_rider_app/app/feature/vehicles/domain/vehicle_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../config/base_response/base_response.dart';
import 'model/vehicle_entity.dart';
@injectable
class GetAllVehiclesUseCase {
  final VehicleRepoContract _repoContract;
  GetAllVehiclesUseCase(this._repoContract);
  Future<BaseResponse<List<VehicleEntity>>> invoke(){
    return _repoContract.getAllVehicles();
  }

}
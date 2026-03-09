import 'package:flowery_rider_app/app/feature/vehicles/domain/get_all_vehicles_use_case.dart';

import '../../config/base_response/base_response.dart';
import '../../config/di/di.dart';
import 'domain/model/vehicle_entity.dart';

Future<void> getAllVehicles<T,E>({
 required void Function() onLoading,
  required void Function(T data) onSuccess,
  required void Function(E error) onError,
}
    )async{
 onLoading();
  final GetAllVehiclesUseCase allVehiclesUseCase=getIt<GetAllVehiclesUseCase>();
  final result=await allVehiclesUseCase.invoke();
  switch(result) {
    case SuccessResponse<List<VehicleEntity>>():
      onSuccess(result.data as T);
      break;
    case ErrorResponse<List<VehicleEntity>>():
     onError(result.error as E);
      break;
  }
}

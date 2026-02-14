import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/get_all_vehicles_use_case.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/vehicle_repo_contract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_vehicles_use_case_test.mocks.dart';
@GenerateMocks([VehicleRepoContract])
void main() {
  test('when calling get all vehicles use case it must call repo', () async{
    VehicleRepoContract repo = MockVehicleRepoContract();
    GetAllVehiclesUseCase useCase = GetAllVehiclesUseCase(repo);
    VehicleEntity entity=VehicleEntity(vehicleType: 'car');
    provideDummy<BaseResponse<List<VehicleEntity>>>(SuccessResponse(data:[entity]));
    when(repo.getAllVehicles()).thenAnswer((_) async => SuccessResponse(data:[ entity]));
    var result =await useCase.invoke();
    expect(result, isA<SuccessResponse<List<VehicleEntity>>>());
    verify(repo.getAllVehicles()).called(1);
  });
}
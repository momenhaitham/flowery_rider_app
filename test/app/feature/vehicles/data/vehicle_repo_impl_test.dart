import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/vehicle_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/vehicle_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_repo_impl_test.mocks.dart';
@GenerateMocks([VehicleDataSourceContract])
void main() {
  test('when calling get all vehicles it must get data from data source', ()async {
    VehicleDataSourceContract dataSource=MockVehicleDataSourceContract();
    VehicleRepoImpl repo=VehicleRepoImpl(dataSource);
    VehiclesResponse response=VehiclesResponse(
      vehicles: [Vehicles(
        type: 'car'
      )]
    );

    provideDummy<BaseResponse<VehiclesResponse>>(SuccessResponse(data: response),);
    when(dataSource.getAllVehicles()).thenAnswer((_) async => SuccessResponse(data: response));
    var result=await repo.getAllVehicles();
    expect(result,isA<SuccessResponse<List<VehicleEntity>>>());
    verify(dataSource.getAllVehicles()).called(1);
  });
}
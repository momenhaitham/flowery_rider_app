import 'dart:io';

import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/api/vehicle_api_client.dart';
import 'package:flowery_rider_app/app/feature/vehicles/api/vehicle_online_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_online_data_source_impl_test.mocks.dart';
@GenerateMocks([VehicleApiClient])
void main() {
  late VehicleOnlineDataSourceImpl dataSource;
  late VehicleApiClient apiClient;
  late VehiclesResponse vehiclesResponse;
  setUpAll(() {
    apiClient = MockVehicleApiClient();
    dataSource = VehicleOnlineDataSourceImpl(apiClient);
    vehiclesResponse = VehiclesResponse(
      vehicles: [Vehicles(
        Id: '1',
        type: 'car',

      )]
    );

  });

  test('when calling get all vehicles with success it must return data', ()async {
    when(apiClient.getAllVehicles()).thenAnswer((_) async => vehiclesResponse);
    final response = await dataSource.getAllVehicles() as SuccessResponse<VehiclesResponse>;
    expect(response.data, vehiclesResponse);
  },
  );
  test('when calling get all vehicles with error it must return error', ()async {
    when(apiClient.getAllVehicles()).thenThrow(IOException);
    final response = await dataSource.getAllVehicles() as ErrorResponse<VehiclesResponse>;
    expect(response.error, UnexpectedError());
  },
  );
}
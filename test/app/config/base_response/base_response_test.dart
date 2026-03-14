import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('BaseStateMapper', () {

    test('should return BaseState with data when SuccessResponse', () {

      final vehicles = [VehicleEntity(vehicleType: "Car")];

      final response =
      SuccessResponse<List<VehicleEntity>>(data: vehicles);

      final result = response.toBaseState();

      expect(result.data, vehicles);
      expect(result.error, null);
      expect(result.isLoading, false);
    });
    test('should return BaseState with error when ErrorResponse', () {

      final Exception error = ServerError(message: "Something went wrong");

      final response =
      ErrorResponse<List<VehicleEntity>>(error: error);

      final result = response.toBaseState();

      expect(result.data, null);
      expect(result.error, error);
      expect(result.isLoading, false);
    });

  });
}
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call to vehicle entity it must return list of vehicle entity', () {
     VehiclesResponse vehiclesResponse=VehiclesResponse(
      vehicles: [Vehicles(
        type: 'car'
      )]
    );
     var result=vehiclesResponse.toVehicleEntity();
     expect(result, isA<List<VehicleEntity>>());
     expect(result?[0], equals(VehicleEntity(vehicleType: 'car')));
  });

}
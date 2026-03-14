import 'package:flutter/material.dart';

import '../../../../vehicles/domain/model/vehicle_entity.dart';

class VehicleController extends ChangeNotifier {
  VehicleEntity? vehicleEntity;

  void changeVehicleEntity(VehicleEntity? vehicle) {
    vehicleEntity = vehicle;
    notifyListeners();
  }
}





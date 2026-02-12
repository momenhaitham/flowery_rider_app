import 'package:equatable/equatable.dart';

class VehicleEntity extends Equatable{
  final String? vehicleType;
  const VehicleEntity({this.vehicleType});

  @override
  List<Object?> get props => [vehicleType];
}
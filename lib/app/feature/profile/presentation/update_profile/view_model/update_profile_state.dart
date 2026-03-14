import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../vehicles/domain/model/vehicle_entity.dart';

class UpdateProfileState extends Equatable {
  final BaseState<String> profileState;
  final BaseState<String> profilePhotoState;
  final BaseState<List<VehicleEntity>>? vehiclesState;

  const UpdateProfileState({
    required this.profileState,
    required this.profilePhotoState,
    required this.vehiclesState,
  });

  UpdateProfileState copyWith({
    BaseState<String>? profileState,
    BaseState<String>? profilePhotoState,
    BaseState<List<VehicleEntity>>? vehiclesState,
  }) {
    return UpdateProfileState(
      profileState: profileState?? this.profileState,
      profilePhotoState: profilePhotoState?? this.profilePhotoState,
      vehiclesState: vehiclesState?? this.vehiclesState,
    );
  }

  @override
  List<Object?> get props => [profileState, profilePhotoState,vehiclesState];
}

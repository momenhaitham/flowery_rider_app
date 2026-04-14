import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';

sealed class ProfileEvent {}
class NavigateToEditProfileOrVehicleScreen extends ProfileEvent {
  final DriverEntity driverEntity;
  final bool isProfile;
  NavigateToEditProfileOrVehicleScreen(this.driverEntity,{this.isProfile=true});
  
}

class ShowLogoutDialogEvent extends ProfileEvent {}

class ShowLanguageDialogEvent extends ProfileEvent {}

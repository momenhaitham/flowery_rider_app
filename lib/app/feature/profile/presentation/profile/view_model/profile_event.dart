import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';

sealed class ProfileEvent {}
class NavigateToEditProfileScreen extends ProfileEvent {
  final DriverEntity driverEntity;

  NavigateToEditProfileScreen(this.driverEntity);

}
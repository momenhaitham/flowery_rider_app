import '../../../domain/model/driver_entity.dart';

sealed class ProfileIntent {}
class GetProfileAction extends ProfileIntent {}
class NavigateToEditProfileIntent extends ProfileIntent {
  final DriverEntity driver;
  NavigateToEditProfileIntent(this.driver);
}


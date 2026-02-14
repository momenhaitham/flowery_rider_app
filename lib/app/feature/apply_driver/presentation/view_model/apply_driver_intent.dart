import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';

sealed class ApplyDriverIntent {}
class InitIntent extends ApplyDriverIntent{}
class ApplyIntent extends ApplyDriverIntent{
  final ApplyDriverRequest driverRequest;
  ApplyIntent({required this.driverRequest});
}
class NavigateToLoginIntent extends ApplyDriverIntent{}
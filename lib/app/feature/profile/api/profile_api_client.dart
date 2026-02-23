import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/endpoint/app_endpoint.dart';
part 'profile_api_client.g.dart';
@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class ProfileApiClient {
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;
  @GET(AppEndPoint.driverProfile)
  Future<DriverAuthResponse> getProfile();

}

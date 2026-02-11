import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/core/endpoint/app_endpoint.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'vehicle_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class VehicleApiClient {
  factory VehicleApiClient(Dio dio, {String baseUrl}) = _VehicleApiClient;
@GET(AppEndPoint.vehicles)
  Future<VehiclesResponse> getAllVehicles();

}

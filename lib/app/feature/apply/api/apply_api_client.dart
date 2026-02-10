import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'apply_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class ApplyApiClient {
  factory ApplyApiClient(Dio dio,{String baseUrl}) = _ApplyApiClient;
  @GET('/app')
  Future<String> applyDriver(@Body() String body);


}

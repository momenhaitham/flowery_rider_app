import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/core/endpoint/app_endpoint.dart';
import 'package:flowery_rider_app/app/feature/apply/data/model/apply_driver_response.dart';
import 'package:flowery_rider_app/app/feature/apply/domain/request/apply_driver_request.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'apply_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class ApplyApiClient {
  factory ApplyApiClient(Dio dio, {String baseUrl}) = _ApplyApiClient;

  @POST(AppEndPoint.applyDriver)
  Future<ApplyDriverResponse> applyDriver(
    @MultiPart() ApplyDriverRequest request,
  );
}

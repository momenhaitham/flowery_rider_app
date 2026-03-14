import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/core/endpoint/app_endpoint.dart';
import 'package:flowery_rider_app/app/feature/auth/data/model/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_auth.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AppEndPoint.login)
  Future<AuthDto> login(@Body() Map<String, dynamic> body);
}

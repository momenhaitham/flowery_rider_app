import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/endpoint/app_endpoint.dart';
import '../../apply_driver/domain/request/apply_driver_request.dart';
import '../data/model/change_password_response.dart';
import '../data/model/profile_photo_response.dart';
import '../domain/request/change_password_request.dart';
part 'profile_api_client.g.dart';
@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class ProfileApiClient {
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;
  @GET(AppEndPoint.driverProfile)
  Future<DriverAuthResponse> getProfile();
  @PUT(AppEndPoint.uploadPhoto)
  Future<ProfilePhotoResponse> uploadPhoto(@Part(name: 'photo') File file);
  @PUT(AppEndPoint.updateProfile)
  Future<DriverAuthResponse> updateProfile(@Body() ApplyDriverRequest request);
  @PUT(AppEndPoint.updateProfile)
  @FormUrlEncoded()
  Future<DriverAuthResponse> updateProfileFormData(@Body() FormData request);
  @PATCH(AppEndPoint.changePassword)
  Future<ChangePasswordResponse> changePassword(
      @Body() ChangePasswordRequest resetPasswordRequest,
      );
}

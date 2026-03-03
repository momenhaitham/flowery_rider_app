import 'dart:io';

import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import '../../../config/base_response/base_response.dart';
import '../domain/request/update_profile_request.dart';
import 'model/profile_photo_response.dart';
abstract class ProfileDataSourceContract {
  Future<BaseResponse<DriverAuthResponse>> getProfile();
  Future<BaseResponse<DriverAuthResponse>> updateProfile(UpdateProfileRequest request);
  Future<BaseResponse<ProfilePhotoResponse>> uploadPhoto(File file);
}

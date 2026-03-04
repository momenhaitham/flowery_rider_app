import 'dart:io';

import 'package:flowery_rider_app/app/feature/profile/domain/request/update_profile_request.dart';

import '../../../config/base_response/base_response.dart';
import 'model/driver_entity.dart';
abstract class ProfileRepoContract {
  Future<BaseResponse<DriverEntity>> getProfile();
  Future<BaseResponse<String>> updateProfile(UpdateProfileRequest request);

  Future<BaseResponse<String>> uploadPhoto(File file);
}

import 'dart:io';

import 'package:flowery_rider_app/app/feature/profile/domain/request/change_password_request.dart';

import '../../../config/base_response/base_response.dart';
import '../../apply_driver/domain/request/apply_driver_request.dart';
import 'model/driver_entity.dart';
abstract class ProfileRepoContract {
  Future<BaseResponse<DriverEntity>> getProfile();
  Future<BaseResponse<String>> updateProfile(ApplyDriverRequest request,{bool isFormData=false});

  Future<BaseResponse<String>> uploadPhoto(File file);
  Future<BaseResponse<String>> changePassword(
      ChangePasswordRequest changePasswordRequest,
      );
}

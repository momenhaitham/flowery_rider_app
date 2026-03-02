import 'dart:io';

import 'package:flowery_rider_app/app/feature/profile/data/profile_data_source_contract.dart';
import 'package:injectable/injectable.dart';
import '../../../config/base_response/base_response.dart';
import '../../apply_driver/data/model/driver_auth_response.dart';
import '../domain/model/driver_entity.dart';
import '../domain/profile_repo_contract.dart';
import '../domain/request/update_profile_request.dart';
import 'model/profile_photo_response.dart';


@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl extends ProfileRepoContract {
  final ProfileDataSourceContract _profileDataSourceContract;
  ProfileRepoImpl(this._profileDataSourceContract);
  @override
  Future<BaseResponse<DriverEntity>> getProfile() async {
    final response = await _profileDataSourceContract.getProfile();
    switch (response) {
      case SuccessResponse<DriverAuthResponse>():
        return SuccessResponse(data: response.data.toDriverEntity());
      case ErrorResponse<DriverAuthResponse>():
        return ErrorResponse(error: response.error);
    }
  }
  @override
  Future<BaseResponse<String>> uploadPhoto(File file) async {
    final response = await _profileDataSourceContract.uploadPhoto(file);
    switch (response) {
      case SuccessResponse<ProfilePhotoResponse>():
        return SuccessResponse(data: response.data.message ?? "");
      case ErrorResponse<ProfilePhotoResponse>():
        return ErrorResponse(error: response.error);
    }
  }

  @override
  Future<BaseResponse<String>> updateProfile(
      UpdateProfileRequest request) async {
    final response = await _profileDataSourceContract.updateProfile(request);
    switch (response) {
      case SuccessResponse<DriverAuthResponse>():
        return SuccessResponse(data: response.data.message ?? "");
      case ErrorResponse<DriverAuthResponse>():
        return ErrorResponse(error: response.error);
    }
  }
 
}

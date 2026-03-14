import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/feature/profile/api/profile_api_client.dart';
import 'package:injectable/injectable.dart';
import '../../../config/api_utils/api_utils.dart';
import '../../../config/base_response/base_response.dart';
import '../../apply_driver/data/model/driver_auth_response.dart';
import '../../apply_driver/domain/request/apply_driver_request.dart';
import '../data/model/profile_photo_response.dart';
import '../data/profile_data_source_contract.dart';
import '../domain/request/change_password_request.dart';
import '../domain/request/update_profile_request.dart';

@Injectable(as: ProfileDataSourceContract)
class ProfileRemoteDataSourceImpl extends ProfileDataSourceContract {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDataSourceImpl(this._profileApiClient);

  @override
  Future<BaseResponse<DriverAuthResponse>> getProfile() =>
      executeApi(() => _profileApiClient.getProfile());
  @override
  Future<BaseResponse<ProfilePhotoResponse>> uploadPhoto(File file) =>
      executeApi(() => _profileApiClient.uploadPhoto(file),);

  @override
  Future<BaseResponse<DriverAuthResponse>> updateProfile(ApplyDriverRequest request,{bool isFormData=false}) =>
      executeApi(() =>isFormData?_profileApiClient.updateProfileFormData(FormData.fromMap(request.toJson())):
      _profileApiClient.updateProfile(request));

}


import 'dart:io';

import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import 'package:flowery_rider_app/app/feature/profile/data/model/profile_photo_response.dart';
import 'package:flowery_rider_app/app/feature/profile/data/profile_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/profile/data/profile_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/request/update_profile_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repo_impl_test.mocks.dart';


@GenerateMocks([ProfileDataSourceContract])
void main() {
  late ProfileRepoImpl profileRepo;
  late ProfileDataSourceContract profileDataSourceContract;
  late DriverAuthResponse driverAuth;
  late UpdateProfileRequest updateProfileRequest;
  late ProfilePhotoResponse profilePhotoResponse;
  late File file;
  setUpAll(() {
    profileDataSourceContract = MockProfileDataSourceContract();
    profileRepo = ProfileRepoImpl(profileDataSourceContract);
    driverAuth = DriverAuthResponse(
      message: 'success',
      driver: Driver(
        firstName: 's',
        lastName: 's',
        email: 's@yahoo.com',
      )
    );
    updateProfileRequest = UpdateProfileRequest(email: 's@yahoo.com');
    profilePhotoResponse = ProfilePhotoResponse(message: 'success');
    file = File('test/resources/fake_image.png');
  });


  test('when calling getProfile it should get data from datasource', () async {
    provideDummy<BaseResponse<DriverAuthResponse>>(SuccessResponse(data: driverAuth));
    when(
      profileDataSourceContract.getProfile(),
    ).thenAnswer((_) => Future.value(SuccessResponse(data: driverAuth)));
    await profileRepo.getProfile();
    verify(profileDataSourceContract.getProfile());
  });
  test(
    'when calling updateProfile it should get data from datasource',
        () async {
      provideDummy<BaseResponse<DriverAuthResponse>>(SuccessResponse(data: driverAuth));
      when(
        profileDataSourceContract.updateProfile(updateProfileRequest),
      ).thenAnswer((_) => Future.value(SuccessResponse(data: driverAuth)));
      await profileRepo.updateProfile(updateProfileRequest);
      verify(profileDataSourceContract.updateProfile(updateProfileRequest));
    },
  );
  test('when calling uploadPhoto it should get data from datasource', () async {
    provideDummy<BaseResponse<ProfilePhotoResponse>>(
      SuccessResponse(data: profilePhotoResponse),
    );
    when(profileDataSourceContract.uploadPhoto(file)).thenAnswer(
          (_) => Future.value(SuccessResponse(data: profilePhotoResponse)),
    );
    await profileRepo.uploadPhoto(file);
    verify(profileDataSourceContract.uploadPhoto(file));
  });
}
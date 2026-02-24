import 'dart:io';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/profile_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/upload_profile_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_driver_data_use_case_test.mocks.dart';


void main() {
  late ProfileRepoContract profileRepo;
  late UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
  late File file;
  setUpAll(() {
    profileRepo = MockProfileRepoContract();
    uploadProfilePhotoUseCase = UploadProfilePhotoUseCase(profileRepo);
    file = File('test/resources/fake_image.png');
  });

  test(
    'when calling upload photo it should get data from repository',
        () async {
      provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
      when(
        profileRepo.uploadPhoto(file),
      ).thenAnswer((_) => Future.value(SuccessResponse(data: 'success')));
      await uploadProfilePhotoUseCase.invoke(file);
      verify(profileRepo.uploadPhoto(file));
    },
  );
}
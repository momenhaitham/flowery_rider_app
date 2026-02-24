import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/profile_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/request/update_profile_request.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/update_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_driver_data_use_case_test.mocks.dart';


void main() {
  late ProfileRepoContract profileRepo;
  late UpdateProfileUseCase updateProfileUseCase;
  late UpdateProfileRequest updateProfileRequest;

  setUpAll(() {
    profileRepo = MockProfileRepoContract();
    updateProfileUseCase = UpdateProfileUseCase(profileRepo);
    updateProfileRequest = UpdateProfileRequest(email: 'test@test.com');
  });

  test(
    'when calling update profile it should get data from repository',
        () async {
      provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
      when(
        profileRepo.updateProfile(updateProfileRequest),
      ).thenAnswer((_) => Future.value(SuccessResponse(data: 'success')));
      await updateProfileUseCase.invoke(updateProfileRequest);
      verify(profileRepo.updateProfile(updateProfileRequest));
    },
  );
}
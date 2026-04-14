import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/profile_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/request/change_password_request.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/change_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_driver_data_use_case_test.mocks.dart';



@GenerateMocks([ProfileRepoContract])
void main() {
  late ProfileRepoContract profileRepo;
  late ChangePasswordUseCase changePasswordUseCase;
  late ChangePasswordRequest changePasswordRequest;

  setUpAll(() {
    profileRepo = MockProfileRepoContract();
    changePasswordUseCase = ChangePasswordUseCase(profileRepo);
    changePasswordRequest = ChangePasswordRequest(
      newPassword: '1234',
      password: '123',
    );
  });

  test(
    'when calling change password it should get data from datasource',
        () async {
      provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
      when(
        profileRepo.changePassword(changePasswordRequest),
      ).thenAnswer((_) => Future.value(SuccessResponse(data: 'success')));
      await changePasswordUseCase.invoke(changePasswordRequest);
      verify(profileRepo.changePassword(changePasswordRequest));
    },
  );
}
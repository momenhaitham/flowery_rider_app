import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/forget_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/forget_password_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/forget_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepoContract])
void main() {
  late ForgetPasswordRepoContract forgetPasswordRepo;
  late ForgetPasswordUseCase forgetPasswordUseCase;
  late ForgetPasswordResponse forgetPasswordResponse;
  late ForgetPasswordRequest forgetPasswordRequest;
  setUpAll(() {
    forgetPasswordRepo = MockForgetPasswordRepoContract();
    forgetPasswordUseCase = ForgetPasswordUseCase(forgetPasswordRepo);
    forgetPasswordResponse = ForgetPasswordResponse();
    forgetPasswordRequest = ForgetPasswordRequest(email: 'email');
  });
  test(
    'when calling forget password it should get data from datasource',
    () async {
      provideDummy<BaseResponse<ForgetPasswordResponse>>(
        SuccessResponse(data: forgetPasswordResponse),
      );
      when(forgetPasswordRepo.forgetPassword(forgetPasswordRequest)).thenAnswer(
        (_) => Future.value(SuccessResponse(data: forgetPasswordResponse)),
      );
      await forgetPasswordUseCase.invoke(forgetPasswordRequest);
      verify(forgetPasswordRepo.forgetPassword(forgetPasswordRequest));
    },
  );
}
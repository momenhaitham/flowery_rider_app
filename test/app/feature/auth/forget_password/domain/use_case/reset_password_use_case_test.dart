import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/reset_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/forget_password_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/reset_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/use_case/reset_password_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'forget_password_use_case_test.mocks.dart';

void main() {
  late ForgetPasswordRepoContract forgetPasswordRepo;
  late ResetPasswordUseCase resetPasswordUseCase;
  late ResetPasswordRequest resetPasswordRequest;
  late ResetPasswordResponse resetPasswordResponse;
  setUpAll(() {
    forgetPasswordRepo = MockForgetPasswordRepoContract();
    resetPasswordUseCase = ResetPasswordUseCase(forgetPasswordRepo);
    resetPasswordRequest =
        ResetPasswordRequest(newPassword: 'password', email: 'email');
    resetPasswordResponse = ResetPasswordResponse();
  });

  test(
    'when calling reset password it should get data from datasource',
    () async {
      provideDummy<BaseResponse<ResetPasswordResponse>>(
        SuccessResponse(data: resetPasswordResponse),
      );
      when(forgetPasswordRepo.resetPassword(resetPasswordRequest)).thenAnswer(
        (_) => Future.value(SuccessResponse(data: resetPasswordResponse)),
      );
      await resetPasswordUseCase.invoke(resetPasswordRequest);
      verify(forgetPasswordRepo.resetPassword(resetPasswordRequest));
    },
  );
}
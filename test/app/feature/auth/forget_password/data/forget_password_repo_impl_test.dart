import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/forget_password_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/forget_password_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/forget_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/reset_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/verify_otp_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/forget_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/reset_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/verify_otp_request.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'forget_password_repo_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordDataSourceContract])
void main() {
  late ForgetPasswordRepoImpl forgetPasswordRepo;
  late ForgetPasswordDataSourceContract forgetPasswordDataSourceContract;
  late ForgetPasswordResponse forgetPasswordResponse;
  late ForgetPasswordRequest forgetPasswordRequest;
  late VerifyOtpRequest verifyOtpRequest;
  late VerifyOtpResponse verifyOtpResponse;

  late ResetPasswordRequest resetPasswordRequest;
  late ResetPasswordResponse resetPasswordResponse;

  setUpAll(() {
    forgetPasswordDataSourceContract = MockForgetPasswordDataSourceContract();
    forgetPasswordRepo = ForgetPasswordRepoImpl(
      forgetPasswordDataSourceContract,
    );
    forgetPasswordRequest = ForgetPasswordRequest(email: 'email');
    forgetPasswordResponse = ForgetPasswordResponse();
    verifyOtpRequest = VerifyOtpRequest(resetCode: 'otp');
    verifyOtpResponse = VerifyOtpResponse();
    resetPasswordRequest =
        ResetPasswordRequest(newPassword: 'password', email: 'email');
    resetPasswordResponse = ResetPasswordResponse();
  });
  test(
    'when calling forget password it should get data from datasource',
    () async {
      provideDummy<BaseResponse<ForgetPasswordResponse>>(
        SuccessResponse(data: forgetPasswordResponse),
      );
      when(
        forgetPasswordDataSourceContract.forgetPassword(forgetPasswordRequest),
      ).thenAnswer(
        (_) => Future.value(SuccessResponse(data: forgetPasswordResponse)),
      );
      await forgetPasswordRepo.forgetPassword(forgetPasswordRequest);
      verify(
        forgetPasswordDataSourceContract.forgetPassword(forgetPasswordRequest),
      );
    },
  );
  test('when calling verify otp it should get data from datasource', () async {
    provideDummy<BaseResponse<VerifyOtpResponse>>(
      SuccessResponse(data: verifyOtpResponse),
    );
    when(
      forgetPasswordDataSourceContract.verifyOtp(verifyOtpRequest),
    ).thenAnswer((_) => Future.value(SuccessResponse(data: verifyOtpResponse)));
    await forgetPasswordRepo.verifyOtp(verifyOtpRequest);
    verify(forgetPasswordDataSourceContract.verifyOtp(verifyOtpRequest));
  });
  test(
    'when calling reset password it should get data from datasource',
    () async {
      provideDummy<BaseResponse<ResetPasswordResponse>>(
        SuccessResponse(data: resetPasswordResponse),
      );
      when(
        forgetPasswordDataSourceContract.resetPassword(resetPasswordRequest),
      ).thenAnswer(
        (_) => Future.value(SuccessResponse(data: resetPasswordResponse)),
      );
      await forgetPasswordRepo.resetPassword(resetPasswordRequest);
      verify(
        forgetPasswordDataSourceContract.resetPassword(resetPasswordRequest),
      );
    },
  );
}
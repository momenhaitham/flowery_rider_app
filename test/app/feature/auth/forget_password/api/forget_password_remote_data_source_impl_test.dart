import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_error/server_error_response.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/api/forget_password_api_client.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/api/forget_password_remote_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/forget_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/reset_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/verify_otp_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/forget_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/reset_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/verify_otp_request.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'forget_password_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([ForgetPasswordApiClient])
void main() {
  late ForgetPasswordApiClient forgetPasswordApiClient;
  late ForgetPasswordRemoteDataSourceImpl forgetPasswordRemoteDataSourceImpl;
  late ForgetPasswordRequest forgetPasswordRequest;
  late VerifyOtpRequest verifyOtpRequest;
  late ResetPasswordRequest resetPasswordRequest;
  late ForgetPasswordResponse forgetPasswordResponse;
  late VerifyOtpResponse verifyOtpResponse;
  late ResetPasswordResponse resetPasswordResponse;
  setUpAll(() {
    forgetPasswordApiClient = MockForgetPasswordApiClient();
    forgetPasswordRemoteDataSourceImpl = ForgetPasswordRemoteDataSourceImpl(
      forgetPasswordApiClient,
    );
    forgetPasswordRequest = ForgetPasswordRequest(email: 'a@email.com');
    forgetPasswordResponse = ForgetPasswordResponse();
    verifyOtpRequest = VerifyOtpRequest(resetCode: '');
    verifyOtpResponse = VerifyOtpResponse();
    resetPasswordRequest = ResetPasswordRequest(
      email: 'a@email.com',
      newPassword: '123',
    );
    resetPasswordResponse = ResetPasswordResponse();
  });

  test(
    'when calling forget password and api return success it should return data',
    () async {
      when(
        forgetPasswordApiClient.forgetPassword(forgetPasswordRequest),
      ).thenAnswer((_) async => forgetPasswordResponse);
      var result =
          await forgetPasswordRemoteDataSourceImpl.forgetPassword(
                forgetPasswordRequest,
              )
              as SuccessResponse<ForgetPasswordResponse>;
      expect(result, isA<SuccessResponse<ForgetPasswordResponse>>());
      expect(result.data, equals(forgetPasswordResponse));
    },
  );
  test(
    'when calling forget password and api return error it should return exact error',
    () async {
      when(
        forgetPasswordApiClient.forgetPassword(forgetPasswordRequest),
      ).thenThrow(IOException);
      var result =
          await forgetPasswordRemoteDataSourceImpl.forgetPassword(
                forgetPasswordRequest,
              )
              as ErrorResponse<ForgetPasswordResponse>;
      expect(result, isA<ErrorResponse<ForgetPasswordResponse>>());
      expect(result.error, equals(UnexpectedError()));
    },
  );
  test(
    'when calling verify otp and api return success it should return data',
    () async {
      when(
        forgetPasswordApiClient.verifyOtp(verifyOtpRequest),
      ).thenAnswer((_) async => verifyOtpResponse);
      var result =
          await forgetPasswordRemoteDataSourceImpl.verifyOtp(verifyOtpRequest)
              as SuccessResponse<VerifyOtpResponse>;
      expect(result, isA<SuccessResponse<VerifyOtpResponse>>());
      expect(result.data, equals(verifyOtpResponse));
    },
  );
  test(
    'when calling verify otp and api return error it should return exact error',
    () async {
      when(forgetPasswordApiClient.verifyOtp(verifyOtpRequest)).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      var result =
          await forgetPasswordRemoteDataSourceImpl.verifyOtp(verifyOtpRequest)
              as ErrorResponse<VerifyOtpResponse>;
      expect(result, isA<ErrorResponse<VerifyOtpResponse>>());
      expect(result.error, equals(ConnectionError()));
    },
  );
  test(
    'when calling reset password and api return success it should return data',
    () async {
      when(
        forgetPasswordApiClient.resetPassword(resetPasswordRequest),
      ).thenAnswer((_) async => resetPasswordResponse);
      var result =
          await forgetPasswordRemoteDataSourceImpl.resetPassword(
                resetPasswordRequest,
              )
              as SuccessResponse<ResetPasswordResponse>;
      expect(result, isA<SuccessResponse<ResetPasswordResponse>>());
      expect(result.data, equals(resetPasswordResponse));
    },
  );
  test(
    'when calling reset password and api return error it should return exact error',
    () async {
      final ServerErrorResponse response = ServerErrorResponse(error: "Fail");
      when(
        forgetPasswordApiClient.resetPassword(resetPasswordRequest),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            data: jsonEncode(response.toJson()),
          ),
        ),
      );

      var result =
          await forgetPasswordRemoteDataSourceImpl.resetPassword(
                resetPasswordRequest,
              )
              as ErrorResponse<ResetPasswordResponse>;
      expect(result, isA<ErrorResponse<ResetPasswordResponse>>());
      expect(result.error, equals(ServerError(message: response.error)));
    },
  );
}
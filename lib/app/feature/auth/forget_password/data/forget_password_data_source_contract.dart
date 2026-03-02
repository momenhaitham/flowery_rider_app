import 'package:flowery_rider_app/app/config/base_response/base_response.dart';

import '../domain/request/forget_password_request.dart';
import '../domain/request/verify_otp_request.dart';
import '../domain/request/reset_password_request.dart';
import 'model/forget_password_response.dart';
import 'model/reset_password_response.dart';
import 'model/verify_otp_response.dart';

abstract class ForgetPasswordDataSourceContract {
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest);
  Future<BaseResponse<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest otpRequest);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest);
}
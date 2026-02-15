import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/forget_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/verify_otp_request.dart';

import '../data/model/forget_password_response.dart';
import '../data/model/reset_password_response.dart';
import '../data/model/verify_otp_response.dart';
import '../domain/request/reset_password_request.dart';
abstract class ForgetPasswordRepoContract {
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest);
  Future<BaseResponse<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest otpRequest);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest);
}
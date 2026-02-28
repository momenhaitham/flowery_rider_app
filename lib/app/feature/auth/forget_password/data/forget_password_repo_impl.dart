import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../domain/forget_password_repo_contract.dart';
import '../domain/request/forget_password_request.dart';
import '../domain/request/verify_otp_request.dart';
import '../domain/request/reset_password_request.dart';
import 'forget_password_data_source_contract.dart';
import 'model/forget_password_response.dart';
import 'model/reset_password_response.dart';
import 'model/verify_otp_response.dart';
@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl extends ForgetPasswordRepoContract {
 final ForgetPasswordDataSourceContract _forgetPasswordDataSourceContract;
 ForgetPasswordRepoImpl(this._forgetPasswordDataSourceContract);
 @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest){
    return _forgetPasswordDataSourceContract.forgetPassword(forgetPasswordRequest);
  }
  @override
  Future<BaseResponse<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest otpRequest){
    return _forgetPasswordDataSourceContract.verifyOtp(otpRequest);
  }
  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest){
    return _forgetPasswordDataSourceContract.resetPassword(resetPasswordRequest);
  }
}
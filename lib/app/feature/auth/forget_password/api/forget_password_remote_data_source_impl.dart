import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../data/forget_password_data_source_contract.dart';
import '../data/model/forget_password_response.dart';
import '../data/model/reset_password_response.dart';
import '../data/model/verify_otp_response.dart';
import '../domain/request/forget_password_request.dart';
import '../domain/request/verify_otp_request.dart';
import '../domain/request/reset_password_request.dart';
import 'forget_password_api_client.dart';
@Injectable(as: ForgetPasswordDataSourceContract)
class ForgetPasswordRemoteDataSourceImpl extends ForgetPasswordDataSourceContract {
  final ForgetPasswordApiClient _forgetPasswordApiClient;
  ForgetPasswordRemoteDataSourceImpl(this._forgetPasswordApiClient);
  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest){
    return executeApi(() => _forgetPasswordApiClient.forgetPassword(forgetPasswordRequest));

  }
  @override
  Future<BaseResponse<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest otpRequest){
   return executeApi(() => _forgetPasswordApiClient.verifyOtp(otpRequest));
  }
  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest){
    return executeApi(() => _forgetPasswordApiClient.resetPassword(resetPasswordRequest));
  }


}
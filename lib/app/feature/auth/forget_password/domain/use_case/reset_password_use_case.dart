import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';




import '../../data/model/reset_password_response.dart';
import '../forget_password_repo_contract.dart';
import '../request/reset_password_request.dart';
@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepoContract _forgetPasswordRepoContract;

  ResetPasswordUseCase(this._forgetPasswordRepoContract);

  Future<BaseResponse<ResetPasswordResponse>> invoke(ResetPasswordRequest resetPasswordRequest) {
    return _forgetPasswordRepoContract.resetPassword(resetPasswordRequest);
  }
}
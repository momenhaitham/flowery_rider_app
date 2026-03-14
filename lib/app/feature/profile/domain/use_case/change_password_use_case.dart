import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../profile_repo_contract.dart';
import '../request/change_password_request.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepoContract _profileRepoContract;

  ChangePasswordUseCase(this._profileRepoContract);

  Future<BaseResponse<String>> invoke(
    ChangePasswordRequest changePasswordRequest,
  ) {
    return _profileRepoContract.changePassword(changePasswordRequest);
  }
}

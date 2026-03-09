
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../apply_driver/domain/request/apply_driver_request.dart';
import '../profile_repo_contract.dart';
import '../request/update_profile_request.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepoContract _profileRepoContract;

  UpdateProfileUseCase(this._profileRepoContract);

  Future<BaseResponse<String>> invoke(ApplyDriverRequest request,{bool isFormData=false}) {
    return _profileRepoContract.updateProfile(request,isFormData: isFormData);
  }
}

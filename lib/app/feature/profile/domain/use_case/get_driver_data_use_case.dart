
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../model/driver_entity.dart';
import '../profile_repo_contract.dart';

@injectable
class GetDriverDataUseCase {
  final ProfileRepoContract _profileRepoContract;

  GetDriverDataUseCase(this._profileRepoContract);

  Future<BaseResponse<DriverEntity>> invoke() {
    return _profileRepoContract.getProfile();
  }
}

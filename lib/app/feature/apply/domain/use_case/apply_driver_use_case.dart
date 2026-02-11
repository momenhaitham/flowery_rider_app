import 'package:flowery_rider_app/app/feature/apply/domain/apply_driver_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../request/apply_driver_request.dart';
@injectable
class ApplyDriverUseCase {
  final ApplyDriverRepoContract _applyDriverRepoContract;
  ApplyDriverUseCase(this._applyDriverRepoContract);
  Future<BaseResponse<String>> invoke(ApplyDriverRequest request){
    return _applyDriverRepoContract.applyDriver(request);
  }

}
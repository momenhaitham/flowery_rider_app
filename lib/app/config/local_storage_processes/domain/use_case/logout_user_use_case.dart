import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/token_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUserUseCase {
  final TokenRepoContract _tokenRepoContract;

  LogoutUserUseCase(this._tokenRepoContract);

  Future<BaseResponse<bool>> invoke() => _tokenRepoContract.clearToken();
}

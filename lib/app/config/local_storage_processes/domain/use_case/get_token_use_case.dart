import 'package:flowery_rider_app/app/config/local_storage_processes/domain/token_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTokenUseCase {
  final TokenRepoContract _tokenRepoContract;

  GetTokenUseCase(this._tokenRepoContract);

  Future<String?> invoke() => _tokenRepoContract.getToken();
}

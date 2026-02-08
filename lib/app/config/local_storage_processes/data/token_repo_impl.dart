import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../domain/storage_data_source_contract.dart';
import '../domain/token_repo_contract.dart';

@Injectable(as: TokenRepoContract)
class TokenRepoImpl extends TokenRepoContract {
  final StorageDataSourceContract _contract;

  TokenRepoImpl(this._contract);

  @override
  Future<BaseResponse<bool>> clearToken() async {
    await _contract.clearRememberMe();
    return _contract.clearToken();
  }

  @override
  bool? getRememberMe() {
    return _contract.getRememberMe();
  }

  @override
  Future<String?> getToken() {
    return _contract.getToken();
  }
}

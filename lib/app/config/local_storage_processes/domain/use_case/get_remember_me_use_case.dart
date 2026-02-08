import 'package:injectable/injectable.dart';

import '../token_repo_contract.dart';

@injectable
class GetRememberMeUseCase {
  final TokenRepoContract _tokenRepoContract;

  GetRememberMeUseCase(this._tokenRepoContract);

  bool? invoke() => _tokenRepoContract.getRememberMe();
}

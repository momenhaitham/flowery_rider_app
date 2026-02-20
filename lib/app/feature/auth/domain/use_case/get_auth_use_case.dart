import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/model/auth_model.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUserUseCase {
  final AuthRepoContract authRepo;
  

  LoginUserUseCase(this.authRepo);

  Future<BaseResponse<AuthModel>> invoke(String email, String password,
      {bool rememberMe = false}) {
    return authRepo.login(email, password, rememberMe: rememberMe);
  }
}

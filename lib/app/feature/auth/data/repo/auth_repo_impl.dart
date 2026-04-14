import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/data/datasource/remote/remote_datasource_contract.dart';
import 'package:flowery_rider_app/app/feature/auth/data/model/auth_response.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/model/auth_model.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/repo/auth_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/local_storage_processes/domain/storage_data_source_contract.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImpl implements AuthRepoContract {
  AuthRemoteDatasourceContract authRemoteDatasourceContract;
  final StorageDataSourceContract storageDataSourceContract;

  AuthRepoImpl(this.authRemoteDatasourceContract,
      this.storageDataSourceContract);
  @override
  Future<void> getAuthData() {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<AuthModel>> login(String email, String password,
      {bool rememberMe = false}) async {
    BaseResponse<AuthDto> response = await authRemoteDatasourceContract.login(
      email,
      password,
    );
    switch (response) {
      case SuccessResponse<AuthDto> successResponse:
        AuthModel authModel = AuthModel(
          message: successResponse.data.message!,
          token: successResponse.data.token,
        );
        await storageDataSourceContract.addRememberMe(rememberMe);
        await storageDataSourceContract.addToken(authModel.token!);
        return SuccessResponse(data: authModel);
      case ErrorResponse<AuthDto> errorResponse:
        return ErrorResponse(error: errorResponse.error);
    }
  }
}

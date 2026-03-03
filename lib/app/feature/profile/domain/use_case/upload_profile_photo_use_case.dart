import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../profile_repo_contract.dart';

@injectable
class UploadProfilePhotoUseCase {
  final ProfileRepoContract _profileRepoContract;

  UploadProfilePhotoUseCase(this._profileRepoContract);

  Future<BaseResponse<String>> invoke(File file) {
    return _profileRepoContract.uploadPhoto(file);
  }
}

import 'dart:io';

import '../../../../apply_driver/domain/request/apply_driver_request.dart';
import '../../../domain/request/update_profile_request.dart';

sealed class UpdateProfileIntent {}

class UploadProfilePhotoAction extends UpdateProfileIntent {
  final File file;

  UploadProfilePhotoAction(this.file);
}

class UpdateProfileAction extends UpdateProfileIntent {
  final ApplyDriverRequest request;

  UpdateProfileAction(this.request);
}

class NavigateToProfileAction extends UpdateProfileIntent {}

class NavigateToChangePasswordAction extends UpdateProfileIntent {}

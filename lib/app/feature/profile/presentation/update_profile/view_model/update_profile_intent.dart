import 'dart:io';

import '../../../domain/request/update_profile_request.dart';

sealed class UpdateProfileIntent {}

class UploadProfilePhotoAction extends UpdateProfileIntent {
  final File file;

  UploadProfilePhotoAction(this.file);
}

class UpdateProfileAction extends UpdateProfileIntent {
  final UpdateProfileRequest request;

  UpdateProfileAction(this.request);
}

class NavigateToProfileAction extends UpdateProfileIntent {}

class NavigateToChangePasswordAction extends UpdateProfileIntent {}

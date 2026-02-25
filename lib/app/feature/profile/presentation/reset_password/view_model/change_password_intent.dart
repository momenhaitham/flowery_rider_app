import '../../../domain/request/change_password_request.dart';

sealed class ChangePasswordIntent {}

class ChangePasswordAction extends ChangePasswordIntent {
  final ChangePasswordRequest changePasswordRequest;

  ChangePasswordAction(this.changePasswordRequest);
}

class BackToEditProfileNavigationAction extends ChangePasswordIntent {}

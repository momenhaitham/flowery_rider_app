

import '../../../domain/request/reset_password_request.dart';

sealed class ResetPasswordIntent {}
class ResetPasswordAction extends ResetPasswordIntent{
  final ResetPasswordRequest resetPasswordRequest;
  ResetPasswordAction(this.resetPasswordRequest);
}
class BackNavigationAction extends ResetPasswordIntent{}




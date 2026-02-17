import '../../../domain/request/forget_password_request.dart';

sealed class ForgetPasswordIntent {}
class ForgetPasswordAction extends ForgetPasswordIntent{
  final ForgetPasswordRequest forgetPasswordRequest;
  ForgetPasswordAction(this.forgetPasswordRequest);
}
class BackToLoginNavigation extends ForgetPasswordIntent{}




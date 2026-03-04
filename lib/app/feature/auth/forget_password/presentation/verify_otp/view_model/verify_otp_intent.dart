import '../../../domain/request/verify_otp_request.dart';

sealed class VerifyOtpIntent {}
class VerifyOtpAction extends VerifyOtpIntent{
  final VerifyOtpRequest verifyOtpRequest;
  VerifyOtpAction(this.verifyOtpRequest);
}
class BackNavigation extends VerifyOtpIntent{}




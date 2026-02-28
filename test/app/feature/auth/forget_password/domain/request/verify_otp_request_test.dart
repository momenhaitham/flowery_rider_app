import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/verify_otp_request.dart';
import 'package:test/test.dart';

void main() {
  test('toJson should serialize all fields', () {
    final dto=VerifyOtpRequest(resetCode: "test_resetCode");
    final json=dto.toJson();
    expect(json["resetCode"], equals(dto.resetCode));
  },);
}
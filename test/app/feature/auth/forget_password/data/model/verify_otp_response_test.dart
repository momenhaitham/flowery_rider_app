
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/verify_otp_response.dart';
import 'package:test/test.dart';

void main() {
  group('VerifyOtpResponse test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "status":"test_status"
      };
      final dto=VerifyOtpResponse.fromJson(json);
      expect(dto.status, equals(json['status']));
    },);
    test('toJson should serialize all fields', () {
      final dto=VerifyOtpResponse(
        status: "test_status"
      );
      final json=dto.toJson();
      expect(json['status'], equals(dto.status));
    },);
  },);
}
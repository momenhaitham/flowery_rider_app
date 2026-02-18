
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/forget_password_request.dart';
import 'package:test/test.dart';

void main() {
  test('toJson should serialize all fields', () {
    final dto=ForgetPasswordRequest(email: 'test_email');
    final json=dto.toJson();
    expect(json['email'], equals(dto.email));
  },);
}
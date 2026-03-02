
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/reset_password_request.dart';
import 'package:test/test.dart';

void main() {
  test("toJson should serialize all fields", () {
    final dto=ResetPasswordRequest(
      email: "test_email", 
      newPassword: "test_newPassword"
    );
    final json=dto.toJson();
    expect(json["email"], equals(dto.email));
    expect(json["newPassword"], equals(dto.newPassword));
  },);
}

import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/reset_password_response.dart';
import 'package:test/test.dart';

void main() {
  group('ResetPasswordResponse test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "message":"test_message",
        "token":"test_token"
      };
      final dto=ResetPasswordResponse.fromJson(json);
      expect(dto.message, equals(json['message']));
      expect(dto.token, equals(json['token']));
    },);
    test('toJson should serialize all fields', () {
      final dto=ResetPasswordResponse(
        message: 'test_message',
        token: 'test_token'
      );
      final json=dto.toJson();
      expect(json['message'], equals(dto.message));
      expect(json['token'], equals(dto.token));
    },);
  },);
}

import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/forget_password_response.dart';
import 'package:test/test.dart';

void main() {
  group('ForgetPasswordResponse test cases',(){
    test('fromJson should parse all fields', () {
      final json={
        "message":"test_message",
        "info":"test_info"
      };
      final dto=ForgetPasswordResponse.fromJson(json);
      expect(dto.message, equals(json['message']));
      expect(dto.info, equals(json['info']));
    },);
    test('toJson should serialize all fields', () {
      final dto=ForgetPasswordResponse(
        message: 'test_message',
        info: 'test_info'
      );
      final json=dto.toJson();
      expect(json['message'], equals(dto.message));
      expect(json['info'], equals(dto.info));
    },);
  });
}
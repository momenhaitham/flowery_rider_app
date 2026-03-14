import 'package:flowery_rider_app/app/feature/home_tab/data/models/user_dto.dart';
import 'package:test/test.dart';
void main() {
  group('UserDTO test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "_id":"_id1",
        "firstName":"firstName1",
        "lastName":"lastName1",
        "email":"email1",
        "gender":"gender1",
        "phone":"phone1",
        "photo":"photo1",
        "passwordResetCode":"passwordResetCode1",
        "resetCodeVerified":false
      };
      final dto=UserDTO.fromJson(json);
      expect(dto.id, equals(json['_id']));
      expect(dto.firstName, equals(json['firstName']));
      expect(dto.lastName, equals(json['lastName']));
      expect(dto.email, equals(json['email']));
      expect(dto.gender, equals(json['gender']));
      expect(dto.phone, equals(json['phone']));
      expect(dto.photo, equals(json['photo']));
      expect(dto.passwordResetCode, equals(json['passwordResetCode']));
      expect(dto.resetCodeVerified, equals(json['resetCodeVerified']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=UserDTO(
        email: 'email1',
        firstName: 'firstName1',
        gender: 'gender1',
        id: 'id1',
        lastName: 'lastName1',
        passwordChangedAt: DateTime(2026,3,4),
        passwordResetCode: 'passwordResetCode1',
        passwordResetExpires: DateTime(2026,4,4),
        phone: 'phone1',
        photo: 'photo1',
        resetCodeVerified: false
      );
      final model=dto.toDomain();
      expect(model.firstName, equals(dto.firstName));
      expect(model.lastName, equals(dto.lastName));
      expect(model.phone, equals(dto.phone));
      expect(model.profileImage, equals('https://flower.elevateegy.com/uploads/${dto.photo}'));
    },);
    test('toJson should serialize all fields', () {
      final dto=UserDTO(
        email: 'email1',
        firstName: 'firstName1',
        gender: 'gender1',
        id: 'id1',
        lastName: 'lastName1',
        passwordChangedAt: DateTime(2026,3,4),
        passwordResetCode: 'passwordResetCode1',
        passwordResetExpires: DateTime(2026,4,4),
        phone: 'phone1',
        photo: 'photo1',
        resetCodeVerified: false
      );
      final json=dto.toJson();
      expect(json['email'], equals(dto.email));
      expect(json['firstName'], equals(dto.firstName));
      expect(json['gender'], equals(dto.gender));
      expect(json['_id'], equals(dto.id));
      expect(json['lastName'], equals(dto.lastName));
      expect(json['passwordChangedAt'], equals(dto.passwordChangedAt?.toIso8601String()));
      expect(json['passwordResetCode'], equals(dto.passwordResetCode));
      expect(json['passwordResetExpires'], equals(dto.passwordResetExpires?.toIso8601String()));
      expect(json['phone'], equals(dto.phone));
      expect(json['photo'], equals(dto.photo));
      expect(json['resetCodeVerified'], equals(dto.resetCodeVerified));
    },);
  },);
}
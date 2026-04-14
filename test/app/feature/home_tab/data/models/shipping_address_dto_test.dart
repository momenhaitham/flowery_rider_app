import 'package:flowery_rider_app/app/feature/home_tab/data/models/shipping_address_dto.dart';
import 'package:test/test.dart';
void main() {
  group('ShippingAddressDTO test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "street":"street1",
        "city":"city1",
        "phone":"phone1",
        "lat":"lat1",
        "long":"long1"
      };
      final dto=ShippingAddressDTO.fromJson(json);
      expect(dto.street, equals(json['street']));
      expect(dto.city, equals(json['city']));
      expect(dto.phone, equals(json['phone']));
      expect(dto.lat, equals(json['lat']));
      expect(dto.long, equals(json['long']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=ShippingAddressDTO(
        city: 'city1',
        lat: 'lat1',
        long: 'long1',
        phone: 'phone1',
        street: 'street1'
      );
      final model=dto.toDomain();
      expect(model.city, equals(dto.city));
      expect(model.street, equals(dto.street));
    },);
    test('toJson should serialize all fields', () {
      final dto=ShippingAddressDTO(
        city: 'city1',
        lat: 'lat1',
        long: 'long1',
        phone: 'phone1',
        street: 'street1'
      );
      final json=dto.toJson();
      expect(json['city'], equals(dto.city));
      expect(json['lat'], equals(dto.lat));
      expect(json['long'], equals(dto.long));
      expect(json['phone'], equals(dto.phone));
      expect(json['street'], equals(dto.street));
    },);
  },);
}
import 'package:flowery_rider_app/app/feature/home_tab/data/models/store_dto.dart';
import 'package:test/test.dart';
void main() {
  group('StoreDTO test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "name":"name1",
        "image":"image1",
        "address":"address1",
        "phoneNumber":"phoneNumber1",
        "latLong":"latLong1"
      };
      final dto=StoreDTO.fromJson(json);
      expect(dto.name, equals(json['name']));
      expect(dto.image, equals(json['image']));
      expect(dto.address, equals(json['address']));
      expect(dto.phoneNumber, equals(json['phoneNumber']));
      expect(dto.latLong, equals(json['latLong']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=StoreDTO(
        address: 'address1',
        image: 'image1',
        latLong: 'latLong1',
        name: 'name1',
        phoneNumber: 'phoneNumber1'
      );
      final model=dto.toDomain();
      expect(model.storeAddress, equals(dto.address));
      expect(model.storeImage, equals(dto.image));
      expect(model.storeName, equals(dto.name));
      expect(model.storePhone, equals(dto.phoneNumber));
    },);
    test('toJson should serialize all fields', () {
      final dto=StoreDTO(
        address: 'address1',
        image: 'image1',
        latLong: 'latLong1',
        name: 'name1',
        phoneNumber: 'phoneNumber1'
      );
      final json=dto.toJson();
      expect(json['address'], equals(dto.address));
      expect(json['image'], equals(dto.image));
      expect(json['latLong'], equals(dto.latLong));
      expect(json['name'], equals(dto.name));
      expect(json['phoneNumber'], equals(dto.phoneNumber));
    },);
  },);
}
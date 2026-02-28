
import 'package:flowery_rider_app/app/feature/home_tab/data/models/meta_data_dto.dart';
import 'package:flowery_rider_app/app/feature/vehicles/data/model/vehicles_response.dart';
import 'package:test/test.dart';

void main() {
  group('MetaDataDto test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "currentPage":1,
        "totalPages":100,
        "totalItems":500,
        "limit":5
      };
      final dto=Metadata.fromJson(json);
      expect(dto.currentPage, equals(json['currentPage']));
      expect(dto.limit, equals(json['limit']));
      expect(dto.totalItems, equals(json['totalItems']));
      expect(dto.totalPages, equals(json['totalPages']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=MetadataDTO(
        currentPage: 1,
        totalPages: 100,
        totalItems: 500,
        limit: 5
      );
      final model=dto.toDomain();
      expect(model.currentPage, equals(dto.currentPage));
      expect(model.limit, equals(dto.limit));
      expect(model.totalItems, equals(dto.totalItems));
      expect(model.totalPages, equals(dto.totalPages));
    },);
    test('toJson should serialize all fields', () {
      final dto=MetadataDTO(
        currentPage: 1,
        totalPages: 100,
        totalItems: 500,
        limit: 5
      );
      final json=dto.toJson();
      expect(json['currentPage'], equals(dto.currentPage));
      expect(json['limit'], equals(dto.limit));
      expect(json['totalItems'], equals(dto.totalItems));
      expect(json['totalPages'], equals(dto.totalPages));
    },);
  },);
}
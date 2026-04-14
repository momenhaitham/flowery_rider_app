import 'package:flowery_rider_app/app/feature/home_tab/data/models/get_pending_orders_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/meta_data_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_details_dto.dart';
import 'package:test/test.dart';
void main() {
  group('GetPendingOrdersResponseTestCases', () {
    test('fromJson should parse all fields', () {
      final json={
        "message":"test_message",
        "orders":[]
      };
      final dto=GetPendingOrdersResponse.fromJson(json);
      expect(dto.message, equals(json['message']));
      expect(dto.orders, equals(json['orders']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=GetPendingOrdersResponse(
        message: "test_message",
        metadata: MetadataDTO(
          currentPage: 1,
          totalPages: 100,
          totalItems: 500,
          limit: 5
        ),
        orders: [
          OrderDetailsDTO(
            id: "id1",
            totalPrice: 300
          ),
          OrderDetailsDTO(
            id: "id2",
            totalPrice: 600
          )
        ]
      );
      final model=dto.toDomain();
      expect(model.metadata?.currentPage, equals(dto.metadata?.currentPage));
      expect(model.metadata?.limit, equals(dto.metadata?.limit));
      expect(model.metadata?.totalItems, equals(dto.metadata?.totalItems));
      expect(model.metadata?.totalPages, equals(dto.metadata?.totalPages));
      expect(model.orders?.length, equals(dto.orders?.length));
      expect(model.orders![0].orderId, equals(dto.orders![0].id));
      expect(model.orders![0].totalPrice, equals(dto.orders![0].totalPrice));
      expect(model.orders![1].orderId, equals(dto.orders![1].id));
      expect(model.orders![1].totalPrice, equals(dto.orders![1].totalPrice));
    },);
    test('toJson should serialize all fields', () {
      final dto=GetPendingOrdersResponse(
        message: "test_message",
        metadata: MetadataDTO(
          currentPage: 1,
          totalPages: 100,
          totalItems: 500,
          limit: 5
        ),
        orders: [
          OrderDetailsDTO(
            id: "id1",
            totalPrice: 300
          ),
          OrderDetailsDTO(
            id: "id2",
            totalPrice: 600
          )
        ]
      );
      final json=dto.toJson();
      expect(json['message'], equals(dto.message));
      expect((json['metadata'] as MetadataDTO).currentPage, equals(dto.metadata?.currentPage));
      expect((json['metadata'] as MetadataDTO).limit, equals(dto.metadata?.limit));
      expect((json['metadata'] as MetadataDTO).totalPages, equals(dto.metadata?.totalPages));
      expect((json['metadata'] as MetadataDTO).totalItems, equals(dto.metadata?.totalItems));
      expect((json['orders'] as List).length, equals(dto.orders?.length));
      expect((json['orders'] as List<OrderDetailsDTO>)[0].id, equals(dto.orders![0].id));
      expect((json['orders'] as List<OrderDetailsDTO>)[0].totalPrice, equals(dto.orders![0].totalPrice));
      expect((json['orders'] as List<OrderDetailsDTO>)[1].id, equals(dto.orders![1].id));
      expect((json['orders'] as List<OrderDetailsDTO>)[1].totalPrice, equals(dto.orders![1].totalPrice));
    },);
  },);
}
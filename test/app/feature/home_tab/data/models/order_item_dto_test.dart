import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_item_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/product_dto.dart';
import 'package:test/test.dart';
void main() {
  group('OrderItemDto test cases', () {
    test('fromJson should parse all fields',(){
      final json={
        "price":200,
        "quantity":1,
        "_id":"id1"
      };
      final dto=OrderItemDTO.fromJson(json);
      expect(dto.id, equals(json['_id']));
      expect(dto.quantity, equals(json['quantity']));
      expect(dto.price, equals(json['price']));
    });
    test('toDomain should map all relevant fields', () {
      final dto=OrderItemDTO(
        product: ProductDTO(id: 'id1'),
        quantity: 3
      );
      final model=dto.toDomain();
      expect(model.product?.productId, equals(dto.product?.id));
      expect(model.quantity, equals(dto.quantity));
    },);
    test('toJson should serialize all fields', () {
      final dto=OrderItemDTO(
        price: 500,
        product: ProductDTO(id: 'id1'),
        quantity: 3,
        id: 'id1'
      );
      final json=dto.toJson();
      expect(json['price'], equals(dto.price));
      expect(json['quantity'], equals(dto.quantity));
      expect(json['_id'], equals(dto.id));
      expect((json['product'] as ProductDTO).id, equals(dto.product?.id));
    },);
  },);
}
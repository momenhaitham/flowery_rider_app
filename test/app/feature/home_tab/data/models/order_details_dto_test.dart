import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_details_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_item_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/product_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/shipping_address_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/store_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/user_dto.dart';
import 'package:test/test.dart';
void main() {
  group('OrderDetailsDto test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "_id":"id1",
        "orderItems":[],
        "totalPrice":500,
        "paymentType":"credit",
        "isPaid":true,
        "isDelivered":false,
        "state":"pending",
        "orderNumber":"1",
        "__v":1
      };
      final dto=OrderDetailsDTO.fromJson(json);
      expect(dto.id, equals(json["_id"]));
      expect(dto.orderItems, equals(json["orderItems"]));
      expect(dto.totalPrice, equals(json["totalPrice"]));
      expect(dto.paymentType, equals(json["paymentType"]));
      expect(dto.isPaid, equals(json["isPaid"]));
      expect(dto.isDelivered, equals(json["isDelivered"]));
      expect(dto.state, equals(json['state']));
      expect(dto.orderNumber, equals(json['orderNumber']));
      expect(dto.v, equals(json['__v']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=OrderDetailsDTO(
        createdAt: DateTime(2026,3,4),
        id: 'id1',
        orderNumber: '1',
        orderItems: [
          OrderItemDTO(id: 'id1',price: 300,product: ProductDTO(id: 'id1'),quantity: 1),
          OrderItemDTO(id: 'id2',price: 200,product: ProductDTO(id: 'id1'),quantity: 1)
        ],
        paymentType: "credit",
        shippingAddress: ShippingAddressDTO(city: 'city1'),
        store: StoreDTO(address: 'address1'),
        totalPrice: 500,
        user: UserDTO(firstName: 'Ahmed')
      );
      final model=dto.toDomain();
      expect(model.createdAt, equals(dto.createdAt?.toIso8601String()));
      expect(model.orderId, equals(dto.id));
      expect(model.orderItems?.length, equals(dto.orderItems?.length));
      expect(model.orderItems![0].product?.productId, equals(dto.orderItems![0].product?.id));
      expect(model.orderItems![0].quantity, equals(dto.orderItems![0].quantity));
      expect(model.orderItems![1].product?.productId, equals(dto.orderItems![1].product?.id));
      expect(model.orderItems![1].quantity, equals(dto.orderItems![1].quantity));
      expect(model.paymentMethod, equals(dto.paymentType));
      expect(model.shippingAddressModel?.city, equals(dto.shippingAddress?.city));
      expect(model.store?.storeAddress, equals(dto.store?.address));
      expect(model.totalPrice, equals(dto.totalPrice));
      expect(model.user?.firstName, equals(dto.user?.firstName));
    },);
    test('toJson should serialize all fields', () {
      final dto=OrderDetailsDTO(
        createdAt: DateTime(2026,3,4),
        isDelivered: false,
        isPaid: true,
        paidAt: DateTime(2026,3,4),
        state: "pending",
        updatedAt: DateTime(2026,3,5),
        v: 1,
        id: 'id1',
        orderNumber: '1',
        orderItems: [
          OrderItemDTO(id: 'id1',price: 300,product: ProductDTO(id: 'id1'),quantity: 1),
          OrderItemDTO(id: 'id2',price: 200,product: ProductDTO(id: 'id1'),quantity: 1)
        ],
        paymentType: "credit",
        shippingAddress: ShippingAddressDTO(city: 'city1'),
        store: StoreDTO(address: 'address1'),
        totalPrice: 500,
        user: UserDTO(firstName: 'Ahmed')
      );
      final json=dto.toJson();
      expect(json["createdAt"], equals(dto.createdAt?.toIso8601String()));
      expect(json["updatedAt"], equals(dto.updatedAt?.toIso8601String()));
      expect(json["paidAt"], equals(dto.paidAt?.toIso8601String()));
      expect(json["isDelivered"], equals(dto.isDelivered));
      expect(json["isPaid"], equals(dto.isPaid));
      expect(json["__v"], equals(dto.v));
      expect(json["orderNumber"], equals(dto.orderNumber));
      expect(json["state"], equals(dto.state));
      expect(json["_id"], equals(dto.id));
      expect((json["orderItems"] as List<OrderItemDTO>).length, equals(dto.orderItems?.length));
      expect((json["orderItems"] as List<OrderItemDTO>)[0].id, equals(dto.orderItems![0].id));
      expect((json["orderItems"] as List<OrderItemDTO>)[0].price, equals(dto.orderItems![0].price));
      expect((json["orderItems"] as List<OrderItemDTO>)[0].product, equals(dto.orderItems![0].product));
      expect((json["orderItems"] as List<OrderItemDTO>)[0].quantity, equals(dto.orderItems![0].quantity));
      expect((json["orderItems"] as List<OrderItemDTO>)[1].id, equals(dto.orderItems![1].id));
      expect((json["orderItems"] as List<OrderItemDTO>)[1].price, equals(dto.orderItems![1].price));
      expect((json["orderItems"] as List<OrderItemDTO>)[1].product, equals(dto.orderItems![1].product));
      expect((json["orderItems"] as List<OrderItemDTO>)[1].quantity, equals(dto.orderItems![1].quantity));
      expect(json["paymentType"], equals(dto.paymentType));
      expect(json["totalPrice"], equals(dto.totalPrice));
      expect((json["shippingAddress"] as ShippingAddressDTO).city, equals(dto.shippingAddress?.city));
      expect((json["user"] as UserDTO).firstName, equals(dto.user?.firstName));
      expect((json["store"] as StoreDTO).address, equals(dto.store?.address));
    },);
  },);
}
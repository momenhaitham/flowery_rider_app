import 'package:flowery_rider_app/app/feature/track_order/domain/models/update_order_state_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_order_state_dto.g.dart';

@JsonSerializable()
class UpdateOrderStateDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "orders")
    Orders? orders;

    UpdateOrderStateDto({
        this.message,
        this.orders,
    });

    UpdateOrderStateModel toModel() => UpdateOrderStateModel(message: message, state: orders?.state);

    factory UpdateOrderStateDto.fromJson(Map<String, dynamic> json) => _$UpdateOrderStateDtoFromJson(json);

    Map<String, dynamic> toJson() => _$UpdateOrderStateDtoToJson(this);
}

@JsonSerializable()
class Orders {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "user")
    String? user;
    @JsonKey(name: "orderItems")
    List<OrderItem>? orderItems;
    @JsonKey(name: "totalPrice")
    int? totalPrice;
    @JsonKey(name: "paymentType")
    String? paymentType;
    @JsonKey(name: "isPaid")
    bool? isPaid;
    @JsonKey(name: "isDelivered")
    bool? isDelivered;
    @JsonKey(name: "state")
    String? state;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "orderNumber")
    String? orderNumber;
    @JsonKey(name: "__v")
    int? v;

    Orders({
        this.id,
        this.user,
        this.orderItems,
        this.totalPrice,
        this.paymentType,
        this.isPaid,
        this.isDelivered,
        this.state,
        this.createdAt,
        this.updatedAt,
        this.orderNumber,
        this.v,
    });

    factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

    Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

@JsonSerializable()
class OrderItem {
    @JsonKey(name: "product")
    String? product;
    @JsonKey(name: "price")
    int? price;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "_id")
    String? id;

    OrderItem({
        this.product,
        this.price,
        this.quantity,
        this.id,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

    Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

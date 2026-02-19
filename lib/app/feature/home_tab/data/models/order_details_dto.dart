import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_item_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/shipping_address_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/store_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/user_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_details_dto.g.dart';
@JsonSerializable()
class OrderDetailsDTO {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "user")
    UserDTO? user;
    @JsonKey(name: "orderItems")
    List<OrderItemDTO>? orderItems;
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
    @JsonKey(name: "store")
    StoreDTO? store;
    @JsonKey(name: "shippingAddress")
    ShippingAddressDTO? shippingAddress;
    @JsonKey(name: "paidAt")
    DateTime? paidAt;

    OrderDetailsDTO({
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
        this.store,
        this.shippingAddress,
        this.paidAt,
    });

    factory OrderDetailsDTO.fromJson(Map<String, dynamic> json) => _$OrderDetailsDTOFromJson(json);

    Map<String, dynamic> toJson() => _$OrderDetailsDTOToJson(this);
    OrderDetailsModel toDomain(){
      return OrderDetailsModel(
        createdAt: createdAt?.toIso8601String(),
        orderId: id,
        orderNumber: orderNumber,
        orderItems: orderItems?.map((e) => e.toDomain(),).toList(),
        paymentMethod: paymentType,
        shippingAddressModel: shippingAddress?.toDomain(),
        store: store?.toDomain(),
        totalPrice: totalPrice,
        user: user?.toDomain()
      );
    }
}
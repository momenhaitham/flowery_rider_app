import 'package:json_annotation/json_annotation.dart';
import '../../domain/model/driver_order_entity.dart';

part 'driver_orders_response.g.dart';

@JsonSerializable()
class DriverOrdersResponseDto {
  final String message;
  final MetadataDto metadata;
  final List<DriverOrderDto> orders;

  const DriverOrdersResponseDto({
    required this.message,
    required this.metadata,
    required this.orders,
  });

  factory DriverOrdersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DriverOrdersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrdersResponseDtoToJson(this);
}

@JsonSerializable()
class MetadataDto {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;

  const MetadataDto({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  factory MetadataDto.fromJson(Map<String, dynamic> json) =>
      _$MetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataDtoToJson(this);
}

@JsonSerializable()
class DriverOrderDto {
  @JsonKey(name: '_id')
  final String id;

  final String driver;
  final DriverOrderNestedDto order;
  final OrderStoreDtoModel store;
  final String createdAt;

  const DriverOrderDto({
    required this.id,
    required this.driver,
    required this.order,
    required this.store,
    required this.createdAt,
  });

  factory DriverOrderDto.fromJson(Map<String, dynamic> json) =>
      _$DriverOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrderDtoToJson(this);

  DriverOrderEntity toEntity() => DriverOrderEntity(
    id: id,
    driverId: driver,
    order: order.toEntity(),
    store: store.toEntity(),
    createdAt: DateTime.parse(createdAt),
  );
}

@JsonSerializable()
class DriverOrderNestedDto {
  @JsonKey(name: '_id')
  final String id;

  final String orderNumber;
  final String state;

  @JsonKey(defaultValue: 0.0)
  final double totalPrice;

  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final OrderUserDtoModel user;

  @JsonKey(defaultValue: [])
  final List<OrderItemDtoModel> orderItems;

  final String createdAt;

  const DriverOrderNestedDto({
    required this.id,
    required this.orderNumber,
    required this.state,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.user,
    required this.orderItems,
    required this.createdAt,
  });

  factory DriverOrderNestedDto.fromJson(Map<String, dynamic> json) =>
      _$DriverOrderNestedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrderNestedDtoToJson(this);

  OrderEntity toEntity() => OrderEntity(
    id: id,
    orderNumber: orderNumber,
    state: state,
    totalPrice: totalPrice,
    paymentType: paymentType,
    isPaid: isPaid,
    isDelivered: isDelivered,
    user: user.toEntity(),
    orderItems: orderItems.map((e) => e.toEntity()).toList(),
    createdAt: DateTime.parse(createdAt),
  );
}

@JsonSerializable()
class OrderUserDtoModel {
  @JsonKey(name: '_id')
  final String id;

  final String firstName;
  final String lastName;

  @JsonKey(defaultValue: 'default-profile.png')
  final String photo;

  @JsonKey(defaultValue: '')
  final String phone;

  const OrderUserDtoModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.phone,
  });

  factory OrderUserDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderUserDtoModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderUserDtoModelToJson(this);

  OrderUserEntity toEntity() => OrderUserEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    photo: photo,
    phone: phone,
  );
}

@JsonSerializable()
class OrderItemDtoModel {
  final OrderItemProductDto product;

  @JsonKey(defaultValue: 0.0)
  final double price;

  @JsonKey(defaultValue: 1)
  final int quantity;

  const OrderItemDtoModel({
    required this.product,
    required this.price,
    required this.quantity,
  });

  factory OrderItemDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoModelToJson(this);

  OrderItemEntity toEntity() => OrderItemEntity(
    productId: product.id,
    price: price,
    quantity: quantity,
    title: product.title,
  );
}

@JsonSerializable()
class OrderItemProductDto {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(defaultValue: 0.0)
  final double price;
  final String? title;

  const OrderItemProductDto({
    required this.id,
    required this.price,
    this.title,
  });

  factory OrderItemProductDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemProductDtoToJson(this);
}

@JsonSerializable()
class OrderStoreDtoModel {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;
  final String latLong;

  const OrderStoreDtoModel({
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
    required this.latLong,
  });

  factory OrderStoreDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStoreDtoModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStoreDtoModelToJson(this);

  OrderStoreEntity toEntity() => OrderStoreEntity(
    name: name,
    image: image,
    address: address,
    phoneNumber: phoneNumber,
    latLong: latLong,
  );
}

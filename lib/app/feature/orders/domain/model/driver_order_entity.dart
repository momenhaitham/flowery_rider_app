class DriverOrderEntity {
  final String id;
  final String driverId;
  final OrderEntity order;
  final OrderStoreEntity store;
  final DateTime createdAt;

  const DriverOrderEntity({
    required this.id,
    required this.driverId,
    required this.order,
    required this.store,
    required this.createdAt,
  });
}

class OrderEntity {
  final String id;
  final String orderNumber;
  final String state; //{ "completed" | "canceled" | "pending" }
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final OrderUserEntity user;
  final List<OrderItemEntity> orderItems;
  final DateTime createdAt;

  const OrderEntity({
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

  bool get isCompleted => state == 'completed';
  bool get isCanceled => state == 'canceled';
  bool get isPending => state == 'pending';
}

class OrderUserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String photo;
  final String phone;

  const OrderUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.phone,
  });

  String get fullName => '$firstName $lastName';
}

class OrderItemEntity {
  final String productId;
  final double price;
  final int quantity;
  final String? title;

  const OrderItemEntity({
    required this.productId,
    required this.price,
    required this.quantity,
    this.title,
  });
}

class OrderStoreEntity {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;
  final String latLong;

  const OrderStoreEntity({
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
    required this.latLong,
  });
}

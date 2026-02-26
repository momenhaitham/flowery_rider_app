import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_item_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/shipping_address_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/store_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/user_model.dart';

class OrderDetailsModel {
  String? orderId;
  UserModel? user;
  StoreModel? store;
  String? paymentMethod;
  String? orderNumber;
  String? createdAt;
  ShippingAddressModel? shippingAddressModel;
  List<OrderItemModel>? orderItems;
  int? totalPrice;

  OrderDetailsModel({
    this.orderId,
    this.user,
    this.store,
    this.shippingAddressModel,
    this.paymentMethod,
    this.orderNumber,
    this.createdAt,
    this.orderItems,
    this.totalPrice,
  });
}
import 'package:flowery_rider_app/app/feature/track_order/domain/models/product_model.dart';

class OrderItemModel {
  ProductModel? product;
  int? quantity;
  
  OrderItemModel({this.product, this.quantity});
}
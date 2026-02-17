import 'package:flowery_rider_app/app/feature/order_details/domain/models/product_model.dart';

class OrderItemModel {
  ProductModel? product;
  int? quantity;
  
  OrderItemModel({this.product, this.quantity});
}
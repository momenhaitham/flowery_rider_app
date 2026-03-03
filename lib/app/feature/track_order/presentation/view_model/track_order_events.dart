import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_details_model.dart';

sealed class TrackOrderEvents {}

class UpdateOrderStateEvent extends TrackOrderEvents {
  final Map<String,dynamic> body;
  final String orderId;
  UpdateOrderStateEvent({required this.body,required this.orderId});
}

class UpdateOrderStateOnFirebaseEvent extends TrackOrderEvents {
  final int currentOrderState;
  final Map<String,dynamic> body;
  final String orderId;
  UpdateOrderStateOnFirebaseEvent({required this.body,required this.orderId,required this.currentOrderState});
}

class AddOrderDocumentToFirebaseEvent extends TrackOrderEvents {
  OrderDetailsModel? orderDetailsModel;
  
  AddOrderDocumentToFirebaseEvent({required this.orderDetailsModel});
}
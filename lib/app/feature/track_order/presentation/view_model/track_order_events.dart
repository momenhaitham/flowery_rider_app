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
  final Map<String,dynamic> body;
  final String orderId;
  AddOrderDocumentToFirebaseEvent({required this.body,required this.orderId});
}
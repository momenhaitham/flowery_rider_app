abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  //order details end points
  static const String updateOrderState = "/orders/state/{orderId}";
  static const String applyDriver = "/drivers/apply";
  static const String vehicles = "/vehicles";
}

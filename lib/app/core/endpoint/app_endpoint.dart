abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  static const String login = "/drivers/signin";
  static const String applyDriver = "/drivers/apply";
  static const String vehicles = "/vehicles";  
  //auth end points
  //order details end points
  static const String updateOrderState = "/orders/state/{orderId}";

  // Auth endpoints
  
  static const String forgetPassword = '/drivers/forgotPassword';
  static const String verifyOtp = '/drivers/verifyResetCode';
  static const String resetPassword = '/drivers/resetPassword';
  //orders end points
  static const String ordersPending='/orders/pending-orders';

  // Driver endpoints
  static const String applyDriver = "/drivers/apply";
  static const String driverProfile = "/drivers/profile-data";
  static const String vehicles = "/vehicles";
  static const String updateProfile = '/auth/editProfile';
  static const String uploadPhoto = '/drivers/upload-photo';
}

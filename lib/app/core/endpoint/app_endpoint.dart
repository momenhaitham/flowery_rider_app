abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  //order details end points
  static const String updateOrderState = "/orders/state/{orderId}";
  //auth end points
  static const String forgetPassword = '/drivers/forgotPassword';
  static const String verifyOtp = '/drivers/verifyResetCode';
  static const String resetPassword = '/drivers/resetPassword';
  
  static const String applyDriver = "/drivers/apply";
  static const String driverProfile = "/drivers/profile-data";
  static const String vehicles = "/vehicles";
  static const String updateProfile = '/auth/editProfile';
  static const String uploadPhoto = '/drivers/upload-photo';
}

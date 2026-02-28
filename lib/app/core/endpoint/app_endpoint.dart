abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  //auth end points
  static const String forgetPassword = '/drivers/forgotPassword';
  static const String verifyOtp = '/drivers/verifyResetCode';
  static const String resetPassword = '/drivers/resetPassword';
  
  static const String applyDriver = "/drivers/apply";
  static const String vehicles = "/vehicles";
}

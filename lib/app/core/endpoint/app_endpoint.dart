abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  static const String login = "/auth/signin";
  static const String applyDriver = "/drivers/apply";
  static const String vehicles = "/vehicles";  
  //auth end points
  static const String forgetPassword = '/drivers/forgotPassword';
  static const String verifyOtp = '/drivers/verifyResetCode';
  static const String resetPassword = '/drivers/resetPassword';
  //orders end points
  static const String ordersPending='/orders/pending-orders';
}

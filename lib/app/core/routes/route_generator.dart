
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/screens/order_delivered_succefully_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view/application_success_screen.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view/apply_driver_screen.dart';
import 'package:flowery_rider_app/app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/screens/track_order_screen.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/views/screens/home_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/forget_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/verify_otp_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view/reset_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/login_Screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/profile_screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/update_profile_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      /// Splash
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// Onboarding
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) =>  OnboardingScreen());

      /// Login
      case Routes.login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());

      /// Home
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      /// Forget Password (support both route names)
      case Routes.forgetPassword:
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      /// Verify OTP
      case Routes.verifyOtpScreen:
        final email = settings.arguments;
        if (email is String) {
          return MaterialPageRoute(
            builder: (_) => VerifyOtpScreen(email),
            settings: settings,
          );
        }
        return unDefinedRoute();

      /// Reset Password
      case Routes.resetPasswordScreen:
        final email = settings.arguments;
        if (email is String) {
          return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(email),
            settings: settings,
          );
        }
        return unDefinedRoute();

      /// Profile
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      /// Update Profile
      case Routes.updateProfileScreen:
        final driver = settings.arguments;
        if (driver is DriverEntity) {
          return MaterialPageRoute(
            builder: (_) => UpdateProfileWidget(driver: driver),
            settings: settings,
          );
        }
        return unDefinedRoute();
    /// Track Order  
      case Routes.trackOrder:
         final OrderDetailsModel orderDetailsModel = settings.arguments as OrderDetailsModel;
         
         return MaterialPageRoute(builder: (_) =>  TrackOrderScreen(orderDetailsModel: orderDetailsModel,));   

      case Routes.orderDeliveredSuccefullyScreen:
        return MaterialPageRoute(builder: (_) =>  OrderDeliveredSuccefullyScreen());  
      
      case Routes.applicationSuccess:
        return MaterialPageRoute(builder: (_) => ApplicationSuccessScreen());
      case Routes.applyDriver:
        return MaterialPageRoute(builder: (_) => ApplyDriverScreen());
      /// Register (placeholder - uses LoginScreen for now)
      case Routes.register:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated at: 2026-03-06 00:16:45.200467

import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flutter/material.dart';

import '../../feature/map_tracking/presentation/map_tracking_argument.dart';
import '../../feature/map_tracking/presentation/view/map_tracking_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';
import '../../feature/splash/presentation/views/splash_screen.dart';

// TODO: Uncomment imports when screens are ready:
// import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
// import 'package:flowery_rider_app/app/feature/login/presentation/views/login_screen.dart';
// import 'package:flowery_rider_app/app/feature/home/presentation/views/home_screen.dart';
// import 'package:flowery_rider_app/app/feature/onboarding/presentation/views/onboarding_screen.dart';
// import 'package:flowery_rider_app/app/feature/forget_password_screen/presentation/views/forget_password_screen_screen.dart';
// import 'package:flowery_rider_app/app/feature/verify_otp_screen/presentation/views/verify_otp_screen_screen.dart';
// import 'package:flowery_rider_app/app/feature/reset_password_screen/presentation/views/reset_password_screen_screen.dart';
// import 'package:flowery_rider_app/app/feature/profile_screen/presentation/views/profile_screen_screen.dart';
// import 'package:flowery_rider_app/app/feature/change_password_screen/presentation/views/change_password_screen_screen.dart';
// import 'package:flowery_rider_app/app/feature/update_profile_screen/presentation/views/update_profile_screen_screen.dart';
// import 'package:flowery_rider_app/app/feature/map_tracking/presentation/views/map_tracking_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        // TODO: Uncomment when SplashScreen is ready
         return MaterialPageRoute(builder: (_) => const SplashScreen());
        return unDefinedRoute();
      case Routes.login:
        // TODO: Uncomment when LoginScreen is ready
         //return MaterialPageRoute(builder: (_) => const LoginScreen());
        return unDefinedRoute();
      case Routes.home:
        // TODO: Uncomment when HomeScreen is ready
        // return MaterialPageRoute(builder: (_) => const HomeScreen());
        return unDefinedRoute();
      case Routes.onboarding:
        // TODO: Uncomment when OnboardingScreen is ready
         return MaterialPageRoute(builder: (_) => const OnboardingScreen());
        return unDefinedRoute();
      case Routes.forgetPasswordScreen:
        // TODO: Uncomment when ForgetPasswordScreenScreen is ready
        // return MaterialPageRoute(builder: (_) => const ForgetPasswordScreenScreen());
        return unDefinedRoute();
      case Routes.verifyOtpScreen:
        // TODO: Uncomment when VerifyOtpScreenScreen is ready
        // return MaterialPageRoute(builder: (_) => const VerifyOtpScreenScreen());
        return unDefinedRoute();
      case Routes.resetPasswordScreen:
        // TODO: Uncomment when ResetPasswordScreenScreen is ready
       //  return MaterialPageRoute(builder: (_) => const ResetPasswordScreenScreen());
        return unDefinedRoute();
      case Routes.profileScreen:
        // TODO: Uncomment when ProfileScreenScreen is ready
         //return MaterialPageRoute(builder: (_) => const ProfileScreenScreen());
        return unDefinedRoute();
      case Routes.changePasswordScreen:
        // TODO: Uncomment when ChangePasswordScreenScreen is ready
        // return MaterialPageRoute(builder: (_) => const ChangePasswordScreenScreen());
        return unDefinedRoute();
      case Routes.updateProfileScreen:
        // TODO: Uncomment when UpdateProfileScreenScreen is ready
        // return MaterialPageRoute(builder: (_) => const UpdateProfileScreenScreen());
        return unDefinedRoute();
      case Routes.mapTracking:
   MapTrackingArgument trackingArgument=settings.arguments as MapTrackingArgument;
    return MaterialPageRoute(builder: (_) =>  MapTrackingScreen(
      trackingId: trackingArgument.orderId,
      choosableEnum: trackingArgument.choosableEnum,
    ));

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

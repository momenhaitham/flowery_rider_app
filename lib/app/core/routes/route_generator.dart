import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/forget_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view/reset_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/verify_otp_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/login/presentation/view/screens/login_screen.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/views/screens/home_screen.dart';
import 'package:flowery_rider_app/app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
         return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
         return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
         return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.onboarding:
         return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.forgetPasswordScreen:
         return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.verifyOtpScreen:
         String email = settings.arguments as String;
         return MaterialPageRoute(builder: (_) =>  VerifyOtpScreen(email));
      case Routes.resetPasswordScreen:
        String email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  ResetPasswordScreen(email));
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

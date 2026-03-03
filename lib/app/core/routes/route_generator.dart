// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated at: 2026-02-09 00:37:18.672613

import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view/orders_screen.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';

import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
import 'package:flowery_rider_app/app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/views/screens/home_screen.dart';

import 'package:flowery_rider_app/app/feature/auth/login/presentation/view/screens/login_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/forget_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/verify_otp_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view/reset_password_screen.dart';

import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/profile_screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/update_profile_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {

    /// Splash
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.login:
        // TODO: Uncomment when LoginScreen is ready
        return unDefinedRoute();
      case Routes.home:
        // TODO: Uncomment when HomeScreen is ready
        // return MaterialPageRoute(builder: (_) => const HomeScreen());
        return unDefinedRoute();
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case Routes.orderDetails:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Order Details\nComing in PR #12',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    /// Onboarding
      case Routes.onboarding:

    /// Login
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

    /// Home
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

    /// Forget Password
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => const ForgetPasswordScreen());

    /// Verify OTP
      case Routes.verifyOtpScreen:
        final email = settings.arguments;
        if (email is String) {
          return MaterialPageRoute(
              builder: (_) => VerifyOtpScreen(email),
              settings: settings);
        }
        return unDefinedRoute();

    /// Reset Password
      case Routes.resetPasswordScreen:
        final email = settings.arguments;
        if (email is String) {
          return MaterialPageRoute(
              builder: (_) => ResetPasswordScreen(email),
              settings: settings);
        }
        return unDefinedRoute();

    /// Profile
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen());

    /// Update Profile
      case Routes.updateProfileScreen:
        final driver = settings.arguments;
        if (driver is DriverEntity) {
          return MaterialPageRoute(
              builder: (_) => UpdateProfileWidget(driver: driver),
              settings: settings);
        }
        return unDefinedRoute();

      default:
        return unDefinedRoute();
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
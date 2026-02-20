// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated at: 2026-02-19 14:10:02.285737

import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flutter/material.dart';

import '../../feature/profile/presentation/profile/view/profile_screen.dart';

// TODO: Uncomment imports when screens are ready:
// import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
// import 'package:flowery_rider_app/app/feature/login/presentation/views/login_screen.dart';
// import 'package:flowery_rider_app/app/feature/home/presentation/views/home_screen.dart';
// import 'package:flowery_rider_app/app/feature/onboarding/presentation/views/onboarding_screen.dart';
// import 'package:flowery_rider_app/app/feature/profile_screen/presentation/views/profile_screen_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        // TODO: Uncomment when SplashScreen is ready
        // return MaterialPageRoute(builder: (_) => const SplashScreen());
        return unDefinedRoute();
      case Routes.login:
        // TODO: Uncomment when LoginScreen is ready
        // return MaterialPageRoute(builder: (_) => const LoginScreen());
        return unDefinedRoute();
      case Routes.home:
        // TODO: Uncomment when HomeScreen is ready
        // return MaterialPageRoute(builder: (_) => const HomeScreen());
        return unDefinedRoute();
      case Routes.onboarding:
        // TODO: Uncomment when OnboardingScreen is ready
        // return MaterialPageRoute(builder: (_) => const OnboardingScreen());
        return unDefinedRoute();
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

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

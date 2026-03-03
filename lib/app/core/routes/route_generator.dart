// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated at: 2026-02-09 00:37:18.672613

import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view/orders_screen.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        // TODO: Uncomment when SplashScreen is ready
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.login:
        // TODO: Uncomment when LoginScreen is ready
        // return MaterialPageRoute(builder: (_) => const LoginScreen());
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

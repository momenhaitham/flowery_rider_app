// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated at: 2026-02-09 00:37:18.672613

import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/models/order_item_model.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/models/product_model.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/models/shipping_address_model.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/models/store_model.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/models/user_model.dart';
import 'package:flowery_rider_app/app/feature/order_details/presentation/views/screens/track_order_screen.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';

// TODO: Uncomment imports when screens are ready:
// import 'package:flowery_rider_app/app/feature/splash/presentation/views/splash_screen.dart';
// import 'package:flowery_rider_app/app/feature/login/presentation/views/login_screen.dart';
// import 'package:flowery_rider_app/app/feature/home/presentation/views/home_screen.dart';
// import 'package:flowery_rider_app/app/feature/onboarding/presentation/views/onboarding_screen.dart';

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
         return MaterialPageRoute(builder: (_) =>  OnboardingScreen());
      case Routes.trackOrder:
         //final OrderDetailsModel orderDetailsModel = settings.arguments as OrderDetailsModel;
         OrderDetailsModel orderDetailsModel = OrderDetailsModel(
          createdAt: "2026-01-16T21:00:17.474Z",
          orderId: "696abaf4e364ef6140470e8d",
          orderItems: [
            OrderItemModel(
              quantity: 2,
              product: ProductModel(
                productId: "673e2bd91159920171828139",
                productName: "Red Wdding Flower",
                productImage: "https://flower.elevateegy.com/uploads/5452abf4-2040-43d7-bb3d-3ae8f53c4576-cover_image.png",
                productPrice: 250
              ),
            )
          ],
          orderNumber: "#126246",
          paymentMethod: "cash",
          store: StoreModel(
            storeAddress: "123 Fixed Address, City, Country",
            storeImage: "https://www.elevateegy.com/elevate.png",
            storeName: "Elevate FlowerApp Store",
            storePhone: "1234567890",
          ),
          totalPrice: 500,
          user: UserModel(
            firstName: "Esraa",
            lastName: "samy",
            phone: "01099097432",
            profileImage: "https://flower.elevateegy.com/uploads/0ab467a9-f2f0-4c98-a17f-09a831a03445-image.jpg"
          ),
          shippingAddressModel: ShippingAddressModel(street: "mohamed koraaim",city: "alexandria")
         );
         return MaterialPageRoute(builder: (_) =>  TrackOrderScreen(orderDetailsModel: orderDetailsModel,));   
        
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

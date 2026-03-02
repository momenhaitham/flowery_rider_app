import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocale.orders),),
    );
  }
}
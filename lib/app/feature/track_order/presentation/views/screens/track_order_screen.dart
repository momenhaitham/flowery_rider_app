import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  final OrderDetailsModel? orderDetailsModel;
  const TrackOrderScreen({super.key,this.orderDetailsModel});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
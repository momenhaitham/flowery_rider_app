import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetailsCard extends StatelessWidget{

  String? state;
  String? orderId;
  String? orderCreatedTime;
  OrderDetailsCard({super.key, this.state,this.orderId,this.orderCreatedTime});
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var formatedDateTime = DateTime.parse(orderCreatedTime??"");
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: height*AppSize.s16,
        width: double .infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppColors.secondaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${AppLocale.status.tr()} : ${state}",style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.successColor),),
            Text("Order ID : $orderId",style: Theme.of(context).textTheme.headlineMedium),
            // ignore: unnecessary_string_interpolations
            Text("${DateFormat("EEE, dd MMM yyyy, hh:mm a").format(formatedDateTime)}")
          ],
        ),
      ),
    );
  }

}
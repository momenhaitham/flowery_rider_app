import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrackOrderIndecatorWidget extends StatelessWidget{
  int orderState;
  TrackOrderIndecatorWidget({super.key, required this.orderState});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  height: height * 0.01,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: orderState >= 1 ? AppColors.successColor : AppColors.lightGrayColor),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  height: height * 0.01,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: orderState >= 2 ? AppColors.successColor : AppColors.lightGrayColor),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  height: height * 0.01,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: orderState >= 3 ? AppColors.successColor : AppColors.lightGrayColor),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  height: height * 0.01,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: orderState >= 4 ? AppColors.successColor : AppColors.lightGrayColor),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  height: height * 0.01,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: orderState >= 5 ? AppColors.successColor : AppColors.lightGrayColor),
                ),
              ),
            ]
          );
  }
}
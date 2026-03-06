import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_locale/app_locale.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';
import '../../domain/model/driver_order_entity.dart';
import 'order_item_row.dart';

class OrderDetailsItemsCard extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsItemsCard({super.key, required this.order});

  Widget _infoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withValues(alpha: 0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset.zero,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...order.orderItems.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: OrderItemRow(item: item),
          ),
        ),

        SizedBox(height: 8.h),
        _infoCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocale.total.tr(),
                style: TextStyle(
                  fontFamily: FontsFamily.roboto,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                'EGP ${order.totalPrice.toStringAsFixed(0)}',
                style: TextStyle(
                  fontFamily: FontsFamily.roboto,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grayColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        _infoCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocale.paymentMethod.tr(),
                style: TextStyle(
                  fontFamily: FontsFamily.roboto,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                order.paymentType == 'cash'
                    ? AppLocale.cashOnDelivery.tr()
                    : order.paymentType,
                style: TextStyle(
                  fontFamily: FontsFamily.roboto,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grayColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

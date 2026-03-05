import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_locale/app_locale.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';
import '../../domain/model/driver_order_entity.dart';

class OrderItemRow extends StatelessWidget {
  final OrderItemEntity item;

  const OrderItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppColors.lightPinkColor,
              borderRadius: BorderRadius.circular(65.r),
            ),
            child: Icon(
              Icons.local_florist_outlined,
              color: AppColors.primaryColor,
              size: 20.r,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? AppLocale.flowerOrder.tr(),
                  style: TextStyle(
                    fontFamily: FontsFamily.inter,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grayColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  'EGP ${item.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontFamily: FontsFamily.roboto,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'X${item.quantity}',
            style: TextStyle(
              fontFamily: FontsFamily.roboto,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

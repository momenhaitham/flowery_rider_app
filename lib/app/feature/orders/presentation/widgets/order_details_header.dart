import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_locale/app_locale.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';
import '../../domain/model/driver_order_entity.dart';

class OrderDetailsHeader extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = order.isCompleted
        ? AppColors.successColor
        : order.isCanceled
            ? AppColors.errorColor
            : AppColors.primaryColor;

    final IconData statusIcon = order.isCompleted
        ? Icons.check_circle_outline
        : order.isCanceled
        ? Icons.cancel_outlined
        : Icons.access_time;

    final String statusLabel = order.isCompleted
        ? AppLocale.completed.tr()
        : order.isCanceled
        ? AppLocale.cancelled.tr()
        : 'Pending';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.baseWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button + title
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.r,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                AppLocale.orderDetails.tr(),
                style: TextStyle(
                  fontFamily: FontsFamily.inter,
                  fontSize: FontSize.s20.sp,
                  fontWeight: FontWeights.medium,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(statusIcon, color: statusColor, size: 20.r),
                  SizedBox(width: 4.w),
                  Text(
                    statusLabel,
                    style: TextStyle(
                      fontFamily: FontsFamily.inter,
                      fontSize: FontSize.s16.sp,
                      fontWeight: FontWeights.medium,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              Text(
                order.orderNumber,
                style: TextStyle(
                  fontFamily: FontsFamily.inter,
                  fontSize: FontSize.s16.sp,
                  fontWeight: FontWeights.semiBold,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

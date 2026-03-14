import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_locale/app_locale.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';
import '../../domain/model/driver_order_entity.dart';
import 'address_info_card.dart';

class OrderListCard extends StatelessWidget {
  final DriverOrderEntity driverOrder;
  final VoidCallback onTap;

  const OrderListCard({
    super.key,
    required this.driverOrder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final order = driverOrder.order;
    final store = driverOrder.store;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF535353).withValues(alpha: 0.25),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocale.flowerOrder.tr(),
              style: TextStyle(
                fontFamily: FontsFamily.inter,
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeights.medium,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _OrderStatusBadge(state: order.state),
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
            SizedBox(height: 16.h),
            Text(
              AppLocale.pickupAddress.tr(),
              style: TextStyle(
                fontFamily: FontsFamily.inter,
                fontSize: FontSize.s12.sp,
                fontWeight: FontWeights.regular,
                color: AppColors.grayColor,
              ),
            ),
            SizedBox(height: 8.h),
            AddressInfoCard(
              name: store.name,
              address: store.address,
              isStore: true,
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocale.userAddress.tr(),
              style: TextStyle(
                fontFamily: FontsFamily.inter,
                fontSize: FontSize.s12.sp,
                fontWeight: FontWeights.regular,
                color: AppColors.grayColor,
              ),
            ),
            SizedBox(height: 8.h),
            AddressInfoCard(
              name: order.user.fullName,
              address: order.user.phone,
              isStore: false,
              photoUrl: order.user.photo,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  final String state;
  const _OrderStatusBadge({required this.state});

  @override
  Widget build(BuildContext context) {
    final isCompleted = state == 'completed';
    final isCanceled = state == 'canceled';

    final Color color = isCompleted
        ? AppColors.successColor
        : isCanceled
        ? AppColors.errorColor
        : Colors.orange;

    final IconData icon = isCompleted
        ? Icons.check_circle_outline
        : isCanceled
        ? Icons.cancel_outlined
        : Icons.access_time;

    final String label = isCompleted
        ? AppLocale.completed.tr()
        : isCanceled
        ? AppLocale.cancelled.tr()
        : 'Pending';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20.r),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontFamily: FontsFamily.inter,
            fontSize: FontSize.s16.sp,
            fontWeight: FontWeights.medium,
            color: color,
          ),
        ),
      ],
    );
  }
}

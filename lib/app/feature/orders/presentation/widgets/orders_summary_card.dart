import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';

class OrdersSummaryCard extends StatelessWidget {
  final int count;
  final String label;
  final IconData icon;
  final Color iconColor;

  const OrdersSummaryCard({
    super.key,
    required this.count,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.lightPinkColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontFamily: FontsFamily.inter,
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeights.medium,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(icon, color: iconColor, size: 16.r),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontsFamily.inter,
                    fontSize: FontSize.s13.sp,
                    fontWeight: FontWeights.medium,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

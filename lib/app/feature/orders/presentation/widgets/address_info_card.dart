// lib/app/feature/orders/presentation/widgets/address_info_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';

class AddressInfoCard extends StatelessWidget {
  final String name;
  final String address;
  final bool isStore;
  final String? photoUrl;

  const AddressInfoCard({
    super.key,
    required this.name,
    required this.address,
    required this.isStore,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withValues(alpha: 0.25),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildAvatar(),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: FontsFamily.inter,
                    fontSize: FontSize.s13.sp,
                    fontWeight: FontWeights.regular,
                    color: AppColors.grayColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (address.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.r,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          address,
                          style: TextStyle(
                            fontFamily: FontsFamily.inter,
                            fontSize: FontSize.s13.sp,
                            fontWeight: FontWeights.regular,
                            color: AppColors.blackColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if (isStore) {
      return Container(
        width: 44.r,
        height: 44.r,
        padding: EdgeInsets.all(8.r),
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            'F',
            style: TextStyle(
              color: AppColors.baseWhiteColor,
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeights.bold,
              fontFamily: FontsFamily.inter,
            ),
          ),
        ),
      );
    }
    return ClipOval(
      child: SizedBox(
        width: 44.r,
        height: 44.r,
        child: (photoUrl != null && photoUrl!.startsWith('http'))
            ? Image.network(
                photoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _defaultUserAvatar(),
              )
            : _defaultUserAvatar(),
      ),
    );
  }

  Widget _defaultUserAvatar() {
    return Container(
      color: AppColors.lightPinkColor,
      child: Icon(Icons.person, size: 24.r, color: AppColors.primaryColor),
    );
  }
}

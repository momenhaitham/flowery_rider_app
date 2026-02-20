import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationSuccessScreen extends StatelessWidget {
  const ApplicationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AssetsImage.bgApply,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Success content
                  _buildSuccessContent(context),

                  const Spacer(),

                  // Login button
                  _buildLoginButton(context),

                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context) {
    return Container(
      width: 315.w,
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 160.w,
            height: 160.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 6.w),
            ),
            child: Icon(
              Icons.check,
              size: 80.sp,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            'application_submitted'.tr(),
            style: TextStyle(
              fontFamily: FontsFamily.inter,
              fontWeight: FontWeights.semiBold,
              fontSize: FontSize.s18,
              color: AppColors.blackColor,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24.h),

          Text(
            'application_submitted_description'.tr(),
            style: TextStyle(
              fontFamily: FontsFamily.inter,
              fontWeight: FontWeights.regular,
              fontSize: FontSize.s16,
              color: AppColors.grayColor,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: 315.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        ),
        child: Text(
          'login'.tr(),
          style: TextStyle(
            fontFamily: FontsFamily.inter,
            fontWeight: FontWeights.medium,
            fontSize: FontSize.s16,
            color: AppColors.whiteColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

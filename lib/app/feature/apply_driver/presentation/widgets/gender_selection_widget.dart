import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelection extends StatelessWidget {
  final String? selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelection({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'gender'.tr(),
          style: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeights.medium,
            color: AppColors.blackColor,
            fontFamily: FontsFamily.inter,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            _GenderOption(
              displayText: 'female'.tr(),
              value: 'Female',
              isSelected: selectedGender == 'Female',
              onTap: () => onGenderSelected('Female'),
            ),
            SizedBox(width: 40.w),
            _GenderOption(
              displayText: 'male'.tr(),
              value: 'Male',
              isSelected: selectedGender == 'Male',
              onTap: () => onGenderSelected('Male'),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String displayText;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.displayText,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.grayColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 8.w),
            Text(
              displayText,
              style: TextStyle(
                fontSize: FontSize.s16,
                color: AppColors.blackColor,
                fontFamily: FontsFamily.inter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

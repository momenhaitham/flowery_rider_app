import 'dart:io';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageUploadField extends StatelessWidget {
  final String label;
  final String placeholder;
  final File? image;
  final VoidCallback onTap;

  const ImageUploadField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSize.s12,
            color: AppColors.grayColor,
            fontFamily: FontsFamily.inter,
          ),
        ),
        SizedBox(height: 4.h),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4.r),
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackColor, width: 1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    image != null ? image!.path.split('/').last : placeholder,
                    style: TextStyle(
                      fontSize: FontSize.s16,
                      color: image != null
                          ? AppColors.blackColor
                          : AppColors.lightGrayColor,
                      fontFamily: FontsFamily.inter,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.upload_outlined,
                  color: AppColors.grayColor,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

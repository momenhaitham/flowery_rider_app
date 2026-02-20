import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
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
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: TextStyle(fontSize: FontSize.s16, color: AppColors.blackColor),
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(
                color: AppColors.blackColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(
                color: AppColors.blackColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(
                color: AppColors.blackColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
      ],
    );
  }
}

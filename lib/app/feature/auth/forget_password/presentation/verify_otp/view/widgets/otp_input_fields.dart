import 'dart:async';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class OtpInputFields extends StatelessWidget {
  final void Function(String code) onCompleted;
  final StreamController<ErrorAnimationType> errorController;

  const OtpInputFields({
    super.key,
    required this.onCompleted,
    required this.errorController,
  });

  @override
  Widget build(BuildContext context) => PinCodeTextField(
    appContext: context,
    errorAnimationController: errorController,
    length: 6,
    keyboardType: TextInputType.number,
    cursorColor: AppColors.blackColor,
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(8),
      fieldHeight: MediaQuery.sizeOf(context).height * .07,
      fieldWidth: MediaQuery.sizeOf(context).width / 7,
      activeColor: AppColors.white60Color,
      inactiveColor: AppColors.white60Color,
      selectedColor: AppColors.white60Color,
      activeFillColor: AppColors.whiteColor,
      inactiveFillColor: AppColors.white60Color,
      selectedFillColor: AppColors.whiteColor,
      errorBorderColor: AppColors.errorColor,
      borderWidth: 1,
    ),
    enableActiveFill: true,
    onCompleted: (value) => onCompleted(value),
    errorAnimationDuration: 400,
    animationDuration: const Duration(milliseconds: 300),
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/core/resources/values_manager.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/core/theme/app_theme.dart';
import 'package:flowery_rider_app/app/core/utils/app_text_field.dart';
import 'package:flowery_rider_app/app/core/validation/app_validators.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_events.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_view_model.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/controller/remember_controller.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/widget/remember_me_widget.dart';
import 'package:flutter/material.dart';

class LoginBodyScreen extends StatefulWidget {
  final LoginViewModel loginViewModel;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final RememberController rememberController;

  const LoginBodyScreen({
    super.key,
    required this.loginViewModel,
    required this.emailController,
    required this.passwordController,
    required this.rememberController,
  });

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppTextField(
              label: 'email'.tr(),
              hint: 'enterEmail'.tr(),
              controller: widget.emailController,
              validator: (value) => AppValidators.validateEmail(value, context),
            ),
            SizedBox(height: AppSize.s12),
            AppTextField(
              label: 'password'.tr(),
              hint: 'enterPassword'.tr(),
              controller: widget.passwordController,
              isPassword: true,
              validator: (value) =>
                  AppValidators.validatePassword(value, context),
            ),
            Padding(
              padding: EdgeInsets.all(AppSize.s10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RememberMeWidget(
                    rememberController: widget.rememberController,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgetPassword);
                    },
                    child: Text(
                      'forgetPassword'.tr(),
                      style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSize.s14,
                        fontWeight: FontWeights.regular,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    widget.loginViewModel.doIntent(
                      LoginEvent(
                        widget.emailController.text,
                        widget.passwordController.text,
                        widget.rememberController.rememberMe,
                      ),
                    );
                  }
                },
                child: Text(
                  'login'.tr(),
                  style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeights.medium,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.s16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.whiteColor,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s50),
                      side: BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, Routes.home),
                child: Text(
                  'continueAsGuest'.tr(),
                  style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeights.medium,
                    color: AppTheme.lightTheme.colorScheme.shadow,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSize.s10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dontHaveAnAccount'.tr(),
                    style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                      fontSize: AppSize.s16,
                      fontWeight: FontWeights.regular,
                    ),
                  ),
                  SizedBox(width: AppSize.s4),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, Routes.register),
                    child: Text(
                      'signup'.tr(),
                      style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSize.s16,
                        fontWeight: FontWeights.regular,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            AppTheme.lightTheme.colorScheme.primary,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

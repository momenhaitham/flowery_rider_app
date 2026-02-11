import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/validation/app_validators.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/reset_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart';
import 'package:flutter/material.dart';
class ResetPasswordBody extends StatefulWidget {
  final String email;
  final ResetPasswordViewModel _resetPasswordViewModel;

  const ResetPasswordBody(
    this._resetPasswordViewModel, {
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @override
  void dispose() {

    super.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
    child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(AppLocale.reset_password.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(AppLocale.resetPasswordQuote.tr(),
                textAlign: TextAlign.center,

              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: AppLocale.enterYourPassword.tr(),
                labelText: AppLocale.password.tr(),
              ),
              validator: (value) =>
                  AppValidators.validatePassword(value, context),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordConfirmController,
                decoration: InputDecoration(
                  hintText: AppLocale.confirmPassword.tr(),
                  labelText: AppLocale.confirmPassword.tr(),
                ),
              validator:
                  (value) =>
                  AppValidators.validateConfirmPassword(
                      value, passwordController.text, context),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget._resetPasswordViewModel.doIntent(
                    ResetPasswordAction(
                      ResetPasswordRequest(
                      email:widget.email,
                      newPassword:passwordConfirmController.text,
                      )
                    ),
                  );
                }
              },
              child: Text(AppLocale.confirm.tr(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    color: AppColors.whiteColor,
                  )),
            ),
          ],
        ),
      ),
    ),
  );
}

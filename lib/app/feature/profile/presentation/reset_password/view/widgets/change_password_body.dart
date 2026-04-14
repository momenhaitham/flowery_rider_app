
import 'package:flutter/material.dart';

import '../../../../../../core/app_locale/app_locale.dart';
import '../../../../../../core/resources/app_colors.dart';

import '../../../../../../core/validation/app_validators.dart';
import '../../../../domain/request/change_password_request.dart';
import '../../view_model/change_password_intent.dart';
import '../../view_model/change_password_view_model.dart';

class ResetPasswordBody extends StatefulWidget {
  final ChangePasswordViewModel _changePasswordViewModel;

  const ResetPasswordBody(this._changePasswordViewModel, {super.key});

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    currentPasswordController.dispose();
    passwordConfirmController.dispose();
    newPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    key: Key('change_password_padding'),
    padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
    child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              key: Key('current_password_text_field'),
              controller: currentPasswordController,
              decoration: InputDecoration(
                hintText: AppLocale.currentPassword,
                labelText: AppLocale.currentPassword,
              ),
              validator: (value) =>
                  AppValidators.validatePassword(value, context),
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: Key('new_password_text_field'),
              controller: newPasswordController,
              decoration: InputDecoration(
                hintText: AppLocale.newPassword,
                labelText: AppLocale.newPassword,
              ),
              validator: (value) =>
                  AppValidators.validatePassword(value, context),
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: Key('confirm_password_text_field'),
              controller: passwordConfirmController,
              decoration: InputDecoration(
                hintText: AppLocale.confirmPassword,
                labelText: AppLocale.confirmPassword,
              ),
              validator: (value) => AppValidators.validateConfirmPassword(
                value,
                newPasswordController.text,
                context,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor: WidgetStatePropertyAll(AppColors.grayColor),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget._changePasswordViewModel.doIntent(
                    ChangePasswordAction(
                      ChangePasswordRequest(
                        password: currentPasswordController.text,
                        newPassword: passwordConfirmController.text,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                AppLocale.update,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

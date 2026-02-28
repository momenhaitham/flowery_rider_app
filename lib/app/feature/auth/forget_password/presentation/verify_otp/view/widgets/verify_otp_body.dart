import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../domain/request/forget_password_request.dart';
import '../../../../domain/request/verify_otp_request.dart';
import '../../../forget_password/view_model/forget_password_intent.dart';
import '../../../forget_password/view_model/forget_password_state.dart';
import '../../view_model/verify_otp_intent.dart';
import '../../view_model/verify_otp_state.dart';
import '../../view_model/verify_otp_view_model.dart';
import 'otp_input_fields.dart';
import 'resend_code_text_button.dart';

class VerifyOtpBody extends StatefulWidget {
  final StreamController<ErrorAnimationType> errorController;
  final String email;
  final VerifyOtpViewModel verifyOtpViewModel;
  final VerifyOtpState verifyOtpState;

  const VerifyOtpBody({
    super.key,
    required this.verifyOtpViewModel,
    required this.errorController,
    required this.email,
    required this.verifyOtpState,
  });

  @override
  State<VerifyOtpBody> createState() => _VerifyOtpBodyState();
}

class _VerifyOtpBodyState extends State<VerifyOtpBody> {
  final ForgetPasswordViewModel _forgetPasswordViewModel =
  getIt<ForgetPasswordViewModel>();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          AppLocale.emailVerification.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            AppLocale.enterOtp.tr(),
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium,
          ),
        ),
        const SizedBox(height: 32),
        OtpInputFields(
          onCompleted: (code) {
            widget.verifyOtpViewModel.doIntent(
              VerifyOtpAction(VerifyOtpRequest(resetCode: code)),
            );
          },
          errorController: widget.errorController,
        ),
        const SizedBox(height: 5),
        Visibility(
          visible: widget.verifyOtpState.verifyOtpState.error != null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.errorColor,
                size: 16,
              ),
              Text(
                AppLocale.invalidOtp.tr(),
                style: Theme
                    .of(
                  context,
                )
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.errorColor),
              ),
            ],
          ),
        ),
        BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
          bloc: _forgetPasswordViewModel,
          listener: (context, state) {
            if (state.forgetPasswordState.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getException(context, state.forgetPasswordState.error)),
                ),
              );
            }
            if (state.forgetPasswordState.data != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.forgetPasswordState.data?.info ?? ''),
                ),
              );
            }
          },
          child: ResendCodeTextButton(
            onPressed: () =>
                _forgetPasswordViewModel.doIntent(
                  ForgetPasswordAction(
                      ForgetPasswordRequest(email: widget.email)),
                ),
          ),
        ),
      ],
    ),
  );
}

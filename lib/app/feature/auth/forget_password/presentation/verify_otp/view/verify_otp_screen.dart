// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../view_model/verify_otp_event.dart';
import '../view_model/verify_otp_state.dart';
import '../view_model/verify_otp_view_model.dart';
import 'widgets/verify_otp_body.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen(this.email, {super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final VerifyOtpViewModel _verifyOtpViewModel = getIt<VerifyOtpViewModel>();
  final StreamController<ErrorAnimationType> _errorController =
  StreamController<ErrorAnimationType>();

  @override
  void initState() {

    super.initState();
    _verifyOtpViewModel.cubitStream.listen((event) {
      if (event is BackNavigationEvent) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _errorController.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpViewModel, VerifyOtpState>(
      bloc: _verifyOtpViewModel,
      listener: (context, state) {
        if (state.verifyOtpState.error != null) {
          _errorController.add(ErrorAnimationType.shake);
        }
        if (state.verifyOtpState.data != null) {
          if (mounted) {
            Navigator.pushNamed(
                context, Routes.resetPasswordScreen, arguments: widget.email);
          }
        }
      },
      builder:
          (context, state) =>
          Scaffold(
            appBar: CustomAppBar(
              text: AppLocale.password.tr(),
              onLeadingIconClicked: () {
                _verifyOtpViewModel.doIntent(BackNavigation());
              },
            ),
            body: Stack(
              children: [
                VerifyOtpBody(
                  email: widget.email,
                  errorController: _errorController,
                  verifyOtpViewModel: _verifyOtpViewModel,
                  verifyOtpState: state,
                ),
                state.verifyOtpState.isLoading == true ?
                const Center(child: CircularProgressIndicator()) :
                const SizedBox.shrink()
                ,

              ],
            ),
          ),
    );
  }
}

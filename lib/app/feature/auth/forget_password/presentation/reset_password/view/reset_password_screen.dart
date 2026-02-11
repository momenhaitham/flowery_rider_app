// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/app_dialog.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/reset_password_event.dart';
import '../view_model/reset_password_state.dart';
import 'widgets/reset_password_body.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen(this.email, {super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ResetPasswordViewModel _resetPasswordViewModel = getIt.get<
      ResetPasswordViewModel>();

  @override
  void initState() {

    super.initState();
    _resetPasswordViewModel.cubitStream.listen((event) {
      if (event is BackNavigationEvent) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordViewModel, ResetPasswordState>(
      bloc: _resetPasswordViewModel,
      listener: (context, state) {
        if (state.resetPasswordState.error != null) {
          Navigator.pop(context);
          AppDialog.viewDialog(context,
              getException(context, state.resetPasswordState.error),
              cancelText: AppLocale.cancel.tr()
          );
        }
        if (state.resetPasswordState.data != null) {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(context,
                Routes.login,
                    (route) => false);
          }
        }
        if (state.resetPasswordState.isLoading == true) {
          AppDialog.viewDialog(context, '');
        }
      },
      child: Scaffold(
            appBar:CustomAppBar(
              onLeadingIconClicked: () {
                _resetPasswordViewModel.doIntent(
                  BackNavigationAction(),
                );
              }, text: AppLocale.password.tr(),
            ),
            body: Stack(
              children: [
                ResetPasswordBody(_resetPasswordViewModel, email: widget.email),
              ],
            ),
          ),
    );
  }
}

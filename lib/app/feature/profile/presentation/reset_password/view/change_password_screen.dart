
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/di/di.dart';

import '../../../../../core/app_locale/app_locale.dart';
import '../../../../../core/reusable_widgets/app_dialoge.dart';
import '../../../../../core/reusable_widgets/custom_app_bar.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/helper_function.dart';
import '../view_model/change_password_event.dart';
import '../view_model/change_password_intent.dart';
import '../view_model/change_password_state.dart';
import '../view_model/change_password_view_model.dart';
import 'widgets/change_password_body.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordViewModel _changePasswordViewModel = getIt
      .get<ChangePasswordViewModel>();

  @override
  void initState() {
    super.initState();
    _changePasswordViewModel.cubitStream.listen((event) {
      if (event is BackToEditProfileNavigationEvent) {
        if (mounted) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordViewModel, ChangePasswordState>(
      bloc: _changePasswordViewModel,
      listener: (context, state) {
        if (state.changePasswordState.error != null) {
          Navigator.pop(context);
          AppDialog.viewDialog(
            context,
            getException(state.changePasswordState.error),
            cancelText: AppLocale.cancel,
          );
        }
        if (state.changePasswordState.data != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocale.passwordChanged),
            ),
          );
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
          }
        }
        if (state.changePasswordState.isLoading == true) {
          AppDialog.viewDialog(context, '');
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onLeadingIconClicked: () {
            _changePasswordViewModel.doIntent(
              BackToEditProfileNavigationAction(),
            );
          },
          text: AppLocale.resetPassword,
        ),
        body: ResetPasswordBody(_changePasswordViewModel),
      ),
    );
  }
}

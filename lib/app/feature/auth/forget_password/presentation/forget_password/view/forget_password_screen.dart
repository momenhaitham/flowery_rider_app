// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/app_dialog.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/widgets/forget_password_body_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/forget_password_event.dart';
import '../view_model/forget_password_intent.dart';
import '../view_model/forget_password_state.dart';
import '../view_model/forget_password_view_model.dart';
class ForgetPasswordScreen extends StatefulWidget {
   const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
final ForgetPasswordViewModel _forgetPasswordViewModel=getIt<ForgetPasswordViewModel>();
@override
  void initState() {

    super.initState();
    _forgetPasswordViewModel.cubitStream.listen((event) {
      if(event is BackToLoginNavigationEvent){
        if(Navigator.canPop(context)) {
        Navigator.pop(context);
        }
      }
    });
  }

@override
void dispose() {

  super.dispose();
  emailController.dispose();
}
  final TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocListener<ForgetPasswordViewModel,ForgetPasswordState>(
      bloc: _forgetPasswordViewModel,
      listener: (context, state) {
        if(state.forgetPasswordState.isLoading==true){
          AppDialog.viewDialog(context, '');
        }
        if(state.forgetPasswordState.error!=null){
          Navigator.pop(context);
          AppDialog.viewDialog(context,
            getException(context, state.forgetPasswordState.error!),
          cancelText: AppLocale.cancel.tr(),

          );
        }
        if(state.forgetPasswordState.data!=null){
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.forgetPasswordState.data?.info??''),
              duration: const Duration(seconds: 2),
            ),
          );
          if (mounted) {
            Navigator.pushNamed(
                context, Routes.verifyOtpScreen, arguments: emailController.text);
          }
        }
      },
      child: Scaffold(

            appBar: CustomAppBar(
              text: AppLocale.password.tr(),
              onLeadingIconClicked: () {
                _forgetPasswordViewModel.doIntent(BackToLoginNavigation());
              },
            ),
            body: ForgetPasswordScreenBody(forgetPasswordViewModel: _forgetPasswordViewModel,
              emailController: emailController,),
          ),
    );
  }
}

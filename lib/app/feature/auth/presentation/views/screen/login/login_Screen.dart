import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/core/resources/values_manager.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/core/theme/app_theme.dart';
import 'package:flowery_rider_app/app/core/utils/app_text_field.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/core/validation/app_validators.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_events.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_states.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_view_model.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/widget/remember_me_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/remember_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final LoginViewModel viewModel;
  LoginScreen({super.key, LoginViewModel? viewModel})
      : viewModel = viewModel ?? getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: Text(
          'login'.tr(),
          style: AppTheme.lightTheme.textTheme.bodyLarge!.copyWith(
            fontSize: FontSize.s20,
            fontWeight: FontWeights.medium,
          ),
        ),
      ),
      leading: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Icon(Icons.arrow_back_ios_new, size: AppSize.s20),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final RememberController rememberController = RememberController();
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<LoginViewModel, LoginStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
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
                      controller: emailController,
                      validator: (value) =>
                          AppValidators.validateEmail(value, context),
                    ),
                    SizedBox(height: AppSize.s12),
                    AppTextField(
                      label: 'password'.tr(),
                      hint: 'enterPassword'.tr(),
                      controller: passwordController,
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
                              rememberController: rememberController),
            
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.forgetPasswordScreen);
                            },
                            child: Text(
                              'forgetPassword'.tr(),
                              style: AppTheme.lightTheme.textTheme.bodyMedium!
                                  .copyWith(
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
                            viewModel.doIntent(
                              LoginEvent(
                                  emailController.text,
                                  passwordController.text,
                                  rememberController.rememberMe
                              ),
            
                            );
                          }
                        },
                        child: Text(
                          'login'.tr(),
                          style: AppTheme.lightTheme.textTheme.titleMedium!
                              .copyWith(
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
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSize.s50,
                                  ),
                                  side: BorderSide(color: AppColors.whiteColor),
                                ),
                              ),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.home),
                        child: Text(
                          'continueAsGuest'.tr(),
                          style: AppTheme.lightTheme.textTheme.titleMedium!
                              .copyWith(
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
                            style: AppTheme.lightTheme.textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: AppSize.s16,
                                  fontWeight: FontWeights.regular,
                                ),
                          ),
                          SizedBox(width: AppSize.s4),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, Routes.register),
                            child: Text(
                              'signup'.tr(),
                              style: AppTheme.lightTheme.textTheme.bodyMedium!
                                  .copyWith(
                                    fontSize: AppSize.s16,
                                    fontWeight: FontWeights.regular,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.loginState?.isLoading == true) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s100,
                    ),
                    child: CircularProgressIndicator(),
                  ),
                  backgroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                );
              },
              barrierDismissible: false,
            );
          } else if (state.loginState?.data != null) {
            Navigator.pop(context); // Close the loading dialog
            Navigator.pushReplacementNamed(context, Routes.home);
          } else if (state.loginState?.error != null) {
            Navigator.pop(context); // Close the loading dialog
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    getException(context, state.loginState?.error),
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  backgroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                );
              },
            );
          }
        },
      ),
    );
  }
}

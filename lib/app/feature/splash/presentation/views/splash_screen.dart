// ignore_for_file: use_build_context_synchronously
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/di/di.dart';
import '../../../../core/utils/helper_function.dart';
import '../view_model/splash_event.dart';
import '../view_model/splash_intent.dart';
import '../view_model/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel splashViewModel = getIt<SplashViewModel>();

  @override
  void initState() {
    super.initState();
    splashViewModel.doIntent(NavigateAction());
    splashViewModel.cubitStream.listen((event) {
      switch (event) {
        case NavigateToLoginEvent():
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.onboarding);
          }
          break;
        case NavigateToMainFlowEvent():
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashViewModel, SplashState>(
      bloc: splashViewModel,
      listener: (context, state) {
        if (state.splashState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(getException(context, state.splashState.error)),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: SvgPicture.asset(AssetsSvg.logoSvg, width: 200)
              .animate()
              .scale(
                delay: Duration(milliseconds: 700),
                duration: Duration(milliseconds: 300),
                
              ),
        ),
      ),
    );
  }
}

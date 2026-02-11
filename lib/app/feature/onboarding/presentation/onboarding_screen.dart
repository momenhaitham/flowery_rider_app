import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget{
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Image.asset(AssetsImage.onBoaedingLogo),
          Text(AppLocale.Welcometo.tr()),
          Text(AppLocale.Floweryriderapp.tr()),
          ElevatedButton(onPressed: () {
            appProvider.changeLocale(context,"en");
          }, child: Text("change lang"))
        ],
      ),
    );
  }
}
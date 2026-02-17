import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/consts/app_consts.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height*0.05),
            Image.asset(AssetsImage.onBoaedingLogo,fit: BoxFit.fill,height: height*0.43,),
            Text(AppLocale.Welcometo.tr(),style: Theme.of(context).textTheme.headlineLarge,),
            Text(AppLocale.Floweryriderapp.tr(),style: Theme.of(context).textTheme.headlineLarge,),
            SizedBox(height: height*0.05,),
            ElevatedButton(onPressed: () {
              
            }, 
            child: Text(AppLocale.login.tr(),style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: FontSize.s20),)
            ),
            SizedBox(height: height*0.02,),
            ElevatedButton(onPressed: () {
              
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightPinkColor),
            child: Text(AppLocale.Applynow.tr(),style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: FontSize.s20),)
            ),
            Spacer(),
            Center(child: Text(AppConsts.appVersion,style: Theme.of(context).textTheme.labelMedium,)),
            SizedBox(height: height*0.09,)
          ],
        ),
      ),
    );
  }
}
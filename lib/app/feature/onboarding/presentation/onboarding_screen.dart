import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Image.asset(AssetsImage.onBoaedingLogo,fit: BoxFit.fill,height: height*0.3,),
          Text(AppLocale.Welcometo.tr(),style: Theme.of(context).textTheme.headlineLarge,),
          Text(AppLocale.Floweryriderapp.tr(),style: Theme.of(context).textTheme.headlineLarge,),
          SizedBox(height: height*0.03,),
          ElevatedButton(onPressed: () {
            appProvider.changeLocale(context,"en");
          }, child: Text("change lang"))
        ],
      ),
    );
  }
}
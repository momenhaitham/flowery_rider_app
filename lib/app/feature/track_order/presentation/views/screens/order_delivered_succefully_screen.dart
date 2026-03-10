import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderDeliveredSuccefullyScreen  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height*AppSize.s0_15,),
            SvgPicture.asset(AssetsImage.successfulImage),
            SizedBox(height: height*AppSize.s0_05,),
            Center(child: Text(AppLocale.thankyou.tr(),style: Theme.of(context).textTheme.headlineLarge?.copyWith(color:AppColors.successColor ),)),
            Center(child: Text(AppLocale.the_order_delivered.tr(),style: Theme.of(context).textTheme.headlineLarge,)),
            Center(child: Text(AppLocale.successfully.tr(),style: Theme.of(context).textTheme.headlineLarge,)),
            SizedBox(height: height*AppSize.s0_05,),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text(AppLocale.done))
          ],
        ),
      ),
    );
  }

}
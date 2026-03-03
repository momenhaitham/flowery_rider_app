import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/routes/app_route.dart';
import '../../view_model/profile_intent.dart';
import '../../view_model/profile_state.dart';

class LogoutDialog extends StatelessWidget {
   LogoutDialog({super.key});
final ProfileViewModel profileViewModel=getIt<ProfileViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
      bloc: profileViewModel,
      listener: (context, state) {
        if(state.isLogout == true) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
        }
      },
      builder:(context, state) =>  Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocale.logout.tr()),
            const SizedBox(height: 16),
            Text(AppLocale.confirmLogout.tr()),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                   style:
                    ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
                      shape:WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          side: BorderSide(color: AppColors.blackColor)
                        )
                      )
                    ),
                    onPressed: () {
                  Navigator.pop(context);
                }, child:Text(AppLocale.cancel.tr(),style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 15.sp
                ),)),
                const SizedBox(width: 16,),
                ElevatedButton(onPressed: () {
                  profileViewModel.doIntent(LogoutAction());
                }, child: Text(AppLocale.logout.tr()))
              ],
            )

          ]
      )),
    );
  }
}

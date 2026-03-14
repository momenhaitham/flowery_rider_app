import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view/tracking_widget.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_state.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
import '../../../../core/app_locale/app_locale.dart';
import '../map_tracking_argument.dart';
import '../view_model/tracking_intent.dart';

class MapTrackingScreen extends StatelessWidget {
   MapTrackingScreen({super.key,this.trackingId,this.choosableEnum=ChoosableEnum.isUser});
   final String? trackingId;
   final ChoosableEnum choosableEnum;
final TrackingViewModel viewModel=getIt<TrackingViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingViewModel,TrackingState>(
      bloc: viewModel..doIntent(GetTrackingDataIntent(trackingId??'')),
      builder:(context, state) =>  SafeArea(
        key: const Key('map_tracking_safe_area'),
        child: Scaffold(
          body:
          state.trackingState.isLoading==true?const Center(
              key: Key('map_tracking_loading_center'),
              child: CircularProgressIndicator()):
              state.trackingState.data!=null?
              TrackingWidget(trackingModel: state.trackingState.data!,
                  viewModel: viewModel,
                  ):
                  state.trackingState.error!=null?Center(
                      key: const Key('map_tracking_error_center'),
                      child: Column(
                    children: [
                      Text(getException(state.trackingState.error,),
                        style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.blackColor
                        ) ,),
                      const SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        viewModel.doIntent(GetTrackingDataIntent(trackingId??''));
                      },
                          child:  Text(AppLocale.tryAgain.tr(),))
        
                    ],
                  )):
                      Text(AppLocale.someThingWrong.tr(),)
        
        ),
      )
    );
  }
}


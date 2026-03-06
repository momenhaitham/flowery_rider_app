import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view/tracking_widget.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_state.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
import '../choosable_enum.dart';
import '../view_model/tracking_intent.dart';

class TrackingScreen extends StatelessWidget {
   TrackingScreen({super.key,this.trackingId,this.choosableEnum=ChoosableEnum.isUser});
   final String? trackingId;
   final ChoosableEnum choosableEnum;
final TrackingViewModel viewModel=getIt<TrackingViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingViewModel,TrackingState>(
      bloc: viewModel..doIntent(GetTrackingDataIntent(trackingId??'696abaf4e364ef6140470e8d')),
      builder:(context, state) =>  SafeArea(
        child: Scaffold(
          body:
          state.trackingState.isLoading==true?const Center(child: CircularProgressIndicator()):
              state.trackingState.data!=null?

                  TrackingWidget(trackingModel: state.trackingState.data!,
                  viewModel: viewModel,
                  ):
                  state.trackingState.error!=null?Center(child: Column(
                    children: [
                      Text(getException(state.trackingState.error,),
                        style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.blackColor
                        ) ,),
                      const SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        viewModel.doIntent(GetTrackingDataIntent(trackingId??'696abaf4e364ef6140470e8d'));
                      },
                          child: const Text('try again'))
        
                    ],
                  )):
                      Text('some thing wrong')
        
        ),
      )
    );
  }
}


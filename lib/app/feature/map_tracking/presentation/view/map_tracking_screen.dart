import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_state.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../view_model/tracking_intent.dart';

class MapTrackingScreen extends StatelessWidget {
  MapTrackingScreen({super.key,this.trackingId});
  final String? trackingId;
final TrackingViewModel _trackingViewModel=getIt<TrackingViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackingViewModel,TrackingState>
      (
      bloc:_trackingViewModel..doIntent(GetTrackingDataIntent(trackingId??'696abaf4e364ef6140470e8d')) ,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                state.trackingState.isLoading==true?
                const CircularProgressIndicator():
                    state.trackingState.data!=null?
                        Column(
                          children: [
                            Text(state.trackingState.data?.orderId??''),
                            Text(state.trackingState.data?.orderState??''),
                            Text(state.trackingState.data?.clientName??''),
                            Text(state.trackingState.data?.storeName??''),
                          ],
                        ):
                        state.trackingState.error!=null?
                        Text(getException(state.trackingState.error)):
                            Container()
              ],
            ),
          ),
        );
      }, listener: (context, state) {

      },);
  }
}

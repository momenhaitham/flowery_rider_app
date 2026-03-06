import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_event.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_intent.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/use_case/get_tracking_data_use_case.dart';
@injectable
class TrackingViewModel  extends CustomCubit<TrackingEvent,TrackingState>{
  final GetTrackingDataUseCase _getTrackingDataUseCase;
  TrackingViewModel(this._getTrackingDataUseCase) : super(TrackingState(trackingState: BaseState()));
  void doIntent(TrackingIntent intent){
    switch(intent){
      case GetTrackingDataIntent():
        _getTrackingData(intent.trackingId);
        break;
    }

  }

  void _getTrackingData(String trackingId) async{
    emit(state.copyWith(trackingState: BaseState(isLoading: true)));
    final response =await _getTrackingDataUseCase.invoke(trackingId);
    switch (response) {
      case SuccessResponse<TrackingModel>():
        emit(
          state.copyWith(
            trackingState: BaseState(isLoading: false, data: response.data),
          ));
          break;
      case ErrorResponse<TrackingModel>():
        emit(
          state.copyWith(
            trackingState: BaseState(isLoading: false, error: response.error),
          ));
        break;
    }
  }

}
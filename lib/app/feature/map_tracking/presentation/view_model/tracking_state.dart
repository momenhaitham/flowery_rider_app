import 'package:equatable/equatable.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import '../../domain/model/tracking_model.dart';
class TrackingState extends Equatable{
  final BaseState<TrackingModel> trackingState;
  const TrackingState({required this.trackingState});
  TrackingState copyWith({
    BaseState<TrackingModel>? trackingState,
  }) {
    return TrackingState(
      trackingState: trackingState ?? this.trackingState,
    );
  }

  @override

  List<Object?> get props => [trackingState];
}




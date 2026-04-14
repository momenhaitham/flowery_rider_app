import 'package:equatable/equatable.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import '../../domain/model/tracking_model.dart';
class TrackingState extends Equatable{
  final BaseState<TrackingModel> trackingState;
  final BaseState<String> userAddress;
  final BaseState<String> storeAddress;
  final String? addressError;
  const TrackingState({required this.trackingState,
    required this.userAddress,required this.storeAddress,this.addressError});
  TrackingState copyWith({
    BaseState<TrackingModel>? trackingState,
    BaseState<String>? userAddress,
    BaseState<String>? storeAddress,
    String? addressError,
  }) {
    return TrackingState(
      trackingState: trackingState ?? this.trackingState,
      userAddress: userAddress??this.userAddress,
      storeAddress: storeAddress??this.storeAddress,
      addressError: addressError??this.addressError,
    );
  }

  @override

  List<Object?> get props => [trackingState,userAddress,storeAddress,addressError];
}




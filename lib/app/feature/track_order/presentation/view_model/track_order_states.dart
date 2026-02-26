import 'package:flowery_rider_app/app/config/base_state/base_state.dart';

class TrackOrderStates {
  BaseState<int>? orderState;

  TrackOrderStates({this.orderState});

  TrackOrderStates copyWith({BaseState<int>? newOrderState}) {
    return TrackOrderStates(orderState: newOrderState ?? orderState);
  }
}
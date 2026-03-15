import 'package:flowery_rider_app/app/config/base_state/base_state.dart';

class TrackOrderStates {
  BaseState<int>? orderState;
  BaseState<String>? getDriverDataState;

  TrackOrderStates({this.orderState,this.getDriverDataState});

  TrackOrderStates copyWith({BaseState<int>? newOrderState,BaseState<String>? newGetDriverDataState}) {
    return TrackOrderStates(orderState: newOrderState ?? orderState,getDriverDataState: newGetDriverDataState ?? getDriverDataState);
  }
}
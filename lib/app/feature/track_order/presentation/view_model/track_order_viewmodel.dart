import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/update_order_state_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/add_order_document_to_firebase_usecase.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/update_order_state_on_firebase_usecase.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/update_order_state_usecase.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_events.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderViewmodel extends Cubit<TrackOrderStates>{
  TrackOrderViewmodel(this._addOrderDocumentToFirebaseUsecase,this._updateOrderStateOnFirebaseUsecase,this._updateOrderStateUsecase):super(TrackOrderStates());
  AddOrderDocumentToFirebaseUsecase _addOrderDocumentToFirebaseUsecase;
  UpdateOrderStateOnFirebaseUsecase _updateOrderStateOnFirebaseUsecase;
  UpdateOrderStateUsecase _updateOrderStateUsecase;

  void doIntent(TrackOrderEvents event){
    switch(event){
      
      case UpdateOrderStateEvent():
        _updateOrderState(body: event.body, orderId: event.orderId);
      case UpdateOrderStateOnFirebaseEvent():
        _updateOrderStateOnFirebase(body: event.body, orderId: event.orderId,currentOrderState: event.currentOrderState);
      case AddOrderDocumentToFirebaseEvent():
        _addOrderDocumentToFirebase(body: event.body, orderId: event.orderId);
    }
  }

  void _addOrderDocumentToFirebase({Map<String,dynamic>? body,String? orderId})async{
    var result = await _addOrderDocumentToFirebaseUsecase.call(body: body, orderId: orderId);
    switch(result){
      case SuccessResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(data: 1))); 
      case ErrorResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(error: result.error,isLoading: false))); 
    }
  }

  void _updateOrderStateOnFirebase({Map<String,dynamic>? body,String? orderId,required int currentOrderState})async{
    
    emit(state.copyWith(newOrderState: BaseState(isLoading: true)));
    var result = await _updateOrderStateOnFirebaseUsecase.call(body: body, orderId: orderId);
    switch(result){
      case SuccessResponse<String>():
        currentOrderState++;
        emit(state.copyWith(newOrderState: BaseState(data: currentOrderState,isLoading: false))); 
      case ErrorResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(error: result.error,isLoading: false))); 
    }
  }

  void _updateOrderState({Map<String,dynamic>? body,String? orderId})async{
    //emit(state.copyWith(newOrderState: BaseState(isLoading: true)));
    var result = await _updateOrderStateUsecase.call(body: body, orderId: orderId);
    switch(result){
      case ErrorResponse<UpdateOrderStateModel>():
        
        emit(state.copyWith(newOrderState: BaseState(error: result.error,isLoading: false))); 
      case SuccessResponse<UpdateOrderStateModel>():
        
    }
  }

  String? editOrderStateOnFireBase(int? stateNum){
    if(stateNum==1){
      return AppLocale.accepted.tr();
    }else if(stateNum==2){
      return AppLocale.picked.tr();
    }else if(stateNum==3){
      return AppLocale.outfordelivery.tr();
    }else if(stateNum==4){
      return AppLocale.arrived.tr();
    }else if(stateNum==5){
      return AppLocale.delivered.tr();
    }
    return null;
  }

  String? editDeliveryStatus(int? stateNum){
    if(stateNum==1){
      return AppLocale.arrivedAtPickuppoint.tr();
    }else if(stateNum==2){
      return AppLocale.startDeliver.tr();
    }else if(stateNum==3){
      return AppLocale.arrivedTotheuser.tr();
    }else if(stateNum==4){
      return AppLocale.deliveredToTheUser.tr();
    }else if(stateNum==5){
      return AppLocale.deliveredToTheUser.tr();
    }
    return null;
  }
}

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/get_driver_data_use_case.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/add_order_document_to_firebase_usecase.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/cancel_order_use_case.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/update_driver_loacation_on_firebase_usecase.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/update_order_state_on_firebase_usecase.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/use_cases/update_order_state_usecase.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_events.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:geolocator/geolocator.dart';

@injectable
class TrackOrderViewmodel extends Cubit<TrackOrderStates>{
  TrackOrderViewmodel(this._addOrderDocumentToFirebaseUsecase,this._cancelOrderUseCase,this._updateDriverLocationOnFireBaseUeecase,this._updateOrderStateOnFirebaseUsecase,this._updateOrderStateUsecase,this._getDriverDataUseCase):super(TrackOrderStates());
  AddOrderDocumentToFirebaseUsecase _addOrderDocumentToFirebaseUsecase;
  UpdateOrderStateOnFirebaseUsecase _updateOrderStateOnFirebaseUsecase;
  UpdateOrderStateUsecase _updateOrderStateUsecase;
  GetDriverDataUseCase _getDriverDataUseCase;
  UpdateDriverLoacationOnFirebaseUsecase? _updateDriverLocationOnFireBaseUeecase;
  CancelOrderUseCase _cancelOrderUseCase;
  DriverEntity? driverData;
  double? driveLat;
  double? driverLong;
  Timer? timer;

  void doIntent(TrackOrderEvents event){
    switch(event){
      
      case UpdateOrderStateEvent():
        _updateOrderState(body: event.body, orderId: event.orderId);
      case UpdateOrderStateOnFirebaseEvent():
        _updateOrderStateOnFirebase(body: event.body, orderId: event.orderId,currentOrderState: event.currentOrderState);
      case AddOrderDocumentToFirebaseEvent():
        _addOrderDocumentToFirebase(orderDetailsModel: event.orderDetailsModel);
      case UpdateDriverLatAndLongOnFireBaseEvent():
        _updateDriverLatAndLongOnFireBase(body: event.body, orderId: event.orderId);
      case CancelOrderEvent():
        _cancelOrder(orderId: event.orderId);
    }
  }

  void _updateDriverLatAndLongOnFireBase({Map<String, dynamic>? body, String? orderId}){
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _updateDriverLocationOnFireBaseUeecase?.call(body:body, orderId: orderId,);
    });
    
   
  }

  void _addOrderDocumentToFirebase({OrderDetailsModel ? orderDetailsModel})async{
    
    await getDriverData();
    
    await getDriverPosition();
    
    

    if(state.getDriverDataState?.isLoading == false && state.getDriverDataState?.error == null){
      _updateOrderState(body: {"state":"inProgress"}, orderId: orderDetailsModel?.orderId);
      var result = await _addOrderDocumentToFirebaseUsecase.call(body: {
           "clientLat":orderDetailsModel?.shippingAddressModel?.lat,
            "clientLong":orderDetailsModel?.shippingAddressModel?.long,
            "clientPhoto":orderDetailsModel?.user?.profileImage,
            "clientName":"${orderDetailsModel?.user?.firstName} ${orderDetailsModel?.user?.lastName}",
            "clientPhoneNumber":orderDetailsModel?.user?.phone,
            "driverLat":driveLat,
            "driverLong":driverLong,
            "driverName":driverData?.firstName??"",
            "driverPhoto":driverData?.photo??"",
            "driverPhoneNumber":driverData?.phone??"",
            "storeLat":orderDetailsModel?.store?.storeLat,
            "storeLong":orderDetailsModel?.store?.storeLong,
            "storeName":orderDetailsModel?.store?.storeName,
            "storePhoto":orderDetailsModel?.store?.storeImage,
            "storePhoneNumber":orderDetailsModel?.store?.storePhone,
            "orderId":orderDetailsModel?.orderId,
            "orderState":"Accepted",
      }
      , 
      orderId: orderDetailsModel?.orderId
      );
      switch(result){
      case SuccessResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(data: 1))); 
      case ErrorResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(data: 1,error: result.error,isLoading: false))); 
      }
    }else{
      return;
    }
  }

  void _updateOrderStateOnFirebase({Map<String,dynamic>? body,String? orderId,required int currentOrderState})async{
    
    
    var result = await _updateOrderStateOnFirebaseUsecase.call(body: body, orderId: orderId);
    switch(result){
      case SuccessResponse<String>():
        currentOrderState++;
        emit(state.copyWith(newOrderState: BaseState(data: currentOrderState,isLoading: false))); 
      case ErrorResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(data: currentOrderState,error: result.error,isLoading: false))); 
    }
  }

  void _updateOrderState({Map<String,dynamic>? body,String? orderId})async{
    
    await _updateOrderStateUsecase.call(body: body, orderId: orderId);
    
  }

  Future<bool> getDriverData()async{
    emit(state.copyWith(newGetDriverDataState: BaseState(isLoading: true))); 
    final response = await _getDriverDataUseCase.invoke();
    switch (response) {
      case SuccessResponse<DriverEntity>():
        driverData = response.data;
        //emit(state.copyWith(newGetDriverDataState: BaseState(error: null)));
        print("Driver Data: ${response.data.firstName}, ${response.data.lastName} NIggggggggggggggr");
        return true;
      case ErrorResponse<DriverEntity>():
        emit(state.copyWith(newGetDriverDataState: BaseState(error: response.error,isLoading: false)));
        //print("Driver Data: ${response.data?.firstName}, ${response.data?.lastName} NIggggggggggggggr");
        return false; 

    }
  }

  Future<void> getDriverPosition() async {

  bool serviceEnabled;
  LocationPermission permission;

 
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    
    emit(state.copyWith(newGetDriverDataState: BaseState(error: Exception('Location services are disabled.'),isLoading: false)));
    return;
  }

 
  permission = await Geolocator.checkPermission();
  print("Permission before request: $permission");
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      
      emit(state.copyWith(newGetDriverDataState: BaseState(error: Exception('Location permissions are denied'),isLoading: false)));
      return ;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    
    emit(state.copyWith(newGetDriverDataState: BaseState(error: Exception('Location permissions are permanently denied'),isLoading: false)));
    return ;
  }

 
  await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  ).then((value) {
   driveLat = value.latitude;
   driverLong = value.longitude;
   print(  "Driver Position: Lat: ${driveLat}, Long: ${driverLong}");
   emit(state.copyWith(newGetDriverDataState: BaseState(error: null,isLoading: false)));
  },).catchError((error) {
    emit(state.copyWith(newGetDriverDataState: BaseState(error: error,isLoading: false)));
  });

  return ;
}
  
  Future<void> _cancelOrder({String? orderId})async{
    emit(state.copyWith(newOrderState: BaseState(isLoading: true)));
    _updateOrderState(body:{"state":"pending"} ,orderId: orderId);
    var result = await _cancelOrderUseCase.call(orderId: orderId);
    switch(result){
      case SuccessResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(data: 6,isLoading: false))); 
      case ErrorResponse<String>():
        emit(state.copyWith(newOrderState: BaseState(error: result.error,isLoading: false))); 
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/track_order/api/api_client/api_client.dart';
import 'package:flowery_rider_app/app/feature/track_order/data/data_sources/track_order_remote_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/track_order/data/models/update_order_state_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


@Injectable(as: TrackOrderRemoteDataSourceContract)
class TrackOrderRemoteDataSourceImpl extends TrackOrderRemoteDataSourceContract{
  TrackOrderApiClient trackOrderApiClient;
  TrackOrderRemoteDataSourceImpl(this.trackOrderApiClient);
  CollectionReference orderDetailsFireBase = FirebaseFirestore.instance.collection('orderDetails');
  @override
  Future<BaseResponse<UpdateOrderStateDto>> updateOrderState({Map<String, dynamic>? body, String? orderId})async {
    return await executeApi(() => trackOrderApiClient.updateOrderState(body: body, orderId: orderId));
  }

  @override
  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({Map<String, dynamic>? body, String? orderId})async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      try{
     var response = await orderDetailsFireBase.doc(orderId).set(body)
     .then((value) => SuccessResponse<String>(data: "Order Accepted"));
      return response;
    }catch(error){
      return ErrorResponse<String>(error: error as Exception);
    }
    } else {
      return ErrorResponse<String>(error: Exception(AppLocale.noInternetConnection.tr()));
    }
    
  }

  

  @override
  Future<BaseResponse<String>> updateOrderStateOnFirebase({Map<String, dynamic>? body, String? orderId})async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)){
      try{
     var response = await orderDetailsFireBase.doc(orderId).set(body)
     .then((value) => SuccessResponse<String>(data: "Order State Updated"));
      return response;
    }catch(error){
      return ErrorResponse<String>(error: error as Exception);
    }
    } else {
      return ErrorResponse<String>(error: Exception(AppLocale.noInternetConnection.tr()));
    }
    
  }

}
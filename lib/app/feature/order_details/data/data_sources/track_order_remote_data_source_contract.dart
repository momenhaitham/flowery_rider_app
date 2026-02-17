import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/order_details/data/models/update_order_state_dto.dart';


abstract class TrackOrderRemoteDataSourceContract {

  Future<BaseResponse<UpdateOrderStateDto>> updateOrderState({Map<String,dynamic>? body,String? orderId});
  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({Map<String,dynamic>? body,String? orderId});
  Future<BaseResponse<String>> updateOrderStateOnFirebase({Map<String,dynamic>? body,String? orderId});

}
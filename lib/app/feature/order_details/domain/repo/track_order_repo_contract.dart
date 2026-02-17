import 'package:flowery_rider_app/app/feature/order_details/domain/models/update_order_state_model.dart';

import '../../../../config/base_response/base_response.dart';

abstract class TrackOrderRepoContract {

  Future<BaseResponse<UpdateOrderStateModel>> updateOrderState({Map<String,dynamic>? body,String? orderId});
  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({Map<String,dynamic>? body,String? orderId});
  Future<BaseResponse<String>> updateOrderStateOnFirebase({Map<String,dynamic>? body,String? orderId});
}
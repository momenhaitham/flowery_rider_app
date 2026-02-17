import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/order_details/data/data_sources/track_order_remote_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/order_details/data/models/update_order_state_dto.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/models/update_order_state_model.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/repo/track_order_repo_contract.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: TrackOrderRepoContract)
class TrackOrderRepoImpl extends TrackOrderRepoContract{
  TrackOrderRemoteDataSourceContract orderDetailsRemoteDataSourceContract;
  TrackOrderRepoImpl(this.orderDetailsRemoteDataSourceContract);

  

  @override
  Future<BaseResponse<UpdateOrderStateModel>> updateOrderState({Map<String, dynamic>? body, String? orderId})async {
    var response =await orderDetailsRemoteDataSourceContract.updateOrderState(body: body, orderId: orderId);
    switch(response){
      case SuccessResponse<UpdateOrderStateDto>():
        return SuccessResponse<UpdateOrderStateModel>(data: response.data.toModel());
      case ErrorResponse<UpdateOrderStateDto>():
        return ErrorResponse<UpdateOrderStateModel>(error: response.error);
    }

  }

  @override
  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({Map<String, dynamic>? body, String? orderId})async {
    var response =await orderDetailsRemoteDataSourceContract.addNewOrderDocumentToFirebase(body: body, orderId: orderId);
    switch(response){
      case SuccessResponse<String>():
        return SuccessResponse<String>(data: response.data);
      case ErrorResponse<String>():
        return ErrorResponse<String>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<String>> updateOrderStateOnFirebase({Map<String, dynamic>? body, String? orderId})async {
    var response =await orderDetailsRemoteDataSourceContract.updateOrderStateOnFirebase(body: body, orderId: orderId);
    switch(response){
      case SuccessResponse<String>():
        return SuccessResponse<String>(data: response.data);
      case ErrorResponse<String>():
        return ErrorResponse<String>(error: response.error);
    }
  }

}
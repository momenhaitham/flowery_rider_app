import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/update_order_state_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/repo/track_order_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class UpdateOrderStateUsecase {
  final TrackOrderRepoContract _trackOrderRepoContract;
  UpdateOrderStateUsecase(this._trackOrderRepoContract);
  Future<BaseResponse<UpdateOrderStateModel>> call({Map<String,dynamic>? body,String? orderId})async=>await _trackOrderRepoContract.updateOrderState(body: body, orderId: orderId);
}
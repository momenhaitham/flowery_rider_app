import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/repo/track_order_repo_contract.dart';
import 'package:injectable/injectable.dart';


@injectable
class UpdateOrderStateOnFirebaseUsecase {
  final TrackOrderRepoContract _trackOrderRepoContract;
  UpdateOrderStateOnFirebaseUsecase(this._trackOrderRepoContract);
  Future<BaseResponse<String>> call({Map<String,dynamic>? body,String? orderId})async=>await _trackOrderRepoContract.updateOrderStateOnFirebase(body: body, orderId: orderId);

}
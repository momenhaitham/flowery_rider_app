import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/repo/track_order_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CancelOrderUseCase {
  final TrackOrderRepoContract _trackOrderRepoContract;

  CancelOrderUseCase(this._trackOrderRepoContract);

  Future<BaseResponse<String>> call({String? orderId})async=>await _trackOrderRepoContract.cancelOrder(orderId: orderId);
}
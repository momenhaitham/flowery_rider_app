import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/order_details/domain/repo/track_order_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddOrderDocumentToFirebaseUsecase {
  final TrackOrderRepoContract _trackOrderRepoContract;
  AddOrderDocumentToFirebaseUsecase(this._trackOrderRepoContract);
  Future<BaseResponse<String>> call({Map<String,dynamic>? body,String? orderId})async=>await _trackOrderRepoContract.addNewOrderDocumentToFirebase(body: body, orderId: orderId);
}
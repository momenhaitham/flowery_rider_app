import 'package:flowery_rider_app/app/feature/map_tracking/domain/tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../model/tracking_model.dart';
@injectable
class GetTrackingDataUseCase {
  final TrackingRepoContract _trackingRepoContract;
  GetTrackingDataUseCase(this._trackingRepoContract);
  Future<BaseResponse<TrackingModel>> invoke(String trackingId) {
     return  _trackingRepoContract.getTrackingData(trackingId);
  }
}
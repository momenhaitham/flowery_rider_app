import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';

abstract class TrackingRepoContract {
  Future<BaseResponse<TrackingModel>> getTrackingData(String trackingId);
}

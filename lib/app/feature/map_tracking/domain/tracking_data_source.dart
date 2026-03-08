import '../../../config/base_response/base_response.dart';
import 'model/tracking_model.dart';

abstract class TrackingDataSourceContract {
  Future<BaseResponse<TrackingModel>> getTrackingData(String trackingId);

}
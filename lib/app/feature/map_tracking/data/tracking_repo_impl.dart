import 'package:flowery_rider_app/app/config/base_response/base_response.dart';

import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:injectable/injectable.dart';

import '../domain/tracking_data_source.dart';
import '../domain/tracking_repo_contract.dart';
@Injectable(as: TrackingRepoContract)
class TrackingRepoImpl extends TrackingRepoContract{
  final TrackingDataSourceContract _trackingDataSourceContract;
  TrackingRepoImpl(this._trackingDataSourceContract);
  @override
  Future<BaseResponse<TrackingModel>> getTrackingData(String trackingId)async {
    return _trackingDataSourceContract.getTrackingData(trackingId);
  }

}
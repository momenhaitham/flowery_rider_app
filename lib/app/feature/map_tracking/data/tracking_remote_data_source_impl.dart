import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';

import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:injectable/injectable.dart';

import '../domain/tracking_data_source.dart';
import '../firebase_manager/firebase_tracking_manager.dart';
@Injectable(as: TrackingDataSourceContract)
class TrackingRemoteDataSourceImpl extends TrackingDataSourceContract{
  final FirebaseTrackingManager _firebaseTrackingManager;
  TrackingRemoteDataSourceImpl(this._firebaseTrackingManager);
  @override
  Future<BaseResponse<TrackingModel>> getTrackingData(String trackingId) =>executeApi(() async => _firebaseTrackingManager.getTrackingInfo(trackingId),);

}
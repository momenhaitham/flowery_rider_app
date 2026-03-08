import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/data/tracking_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/tracking_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tracking_repo_impl_test.mocks.dart';
@GenerateMocks([TrackingDataSourceContract])
void main() {

  late TrackingDataSourceContract remoteDataSource;
  late TrackingRepoImpl repo;
  late final TrackingModel model;
  setUpAll(() {
    remoteDataSource=MockTrackingDataSourceContract();
    repo=TrackingRepoImpl(remoteDataSource);
    model=TrackingModel(
      orderId: '123',
      orderState: 'delivered',
    );
  },);

  test('when calling get tracking data it must get data from data source', () async{
   provideDummy<BaseResponse<TrackingModel>>(SuccessResponse(data: model));
   when(remoteDataSource.getTrackingData('123')).thenAnswer((_) async => Future.value(SuccessResponse(data: model)));
   var result=await repo.getTrackingData('123')as SuccessResponse<TrackingModel>;
   expect(result.data,model);
   verify(remoteDataSource.getTrackingData('123')).called(1);
  });
}
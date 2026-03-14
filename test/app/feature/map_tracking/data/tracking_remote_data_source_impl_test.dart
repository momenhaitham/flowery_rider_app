import 'dart:io';

import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/data/tracking_remote_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/firebase_manager/firebase_tracking_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tracking_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([FirebaseTrackingManager])
void main() {
 late final FirebaseTrackingManager manager;
 late TrackingRemoteDataSourceImpl remoteDataSource;
 late final TrackingModel model;
setUpAll(() {
  manager=MockFirebaseTrackingManager();
  remoteDataSource=TrackingRemoteDataSourceImpl(manager);
  model=TrackingModel(
    orderId: '123',
    orderState: 'delivered',
  );
},);

  test('when calling get tracking data with success it must get data', () async{
    when(manager.getTrackingInfo('123')).thenAnswer((_) async => model);
    var result=await remoteDataSource.getTrackingData('123') as SuccessResponse<TrackingModel>;
    expect(result.data, model);
    expect(result.data.orderId, '123');

  });
 test('when calling get tracking data with error it must return correct exception', () async{
   when(manager.getTrackingInfo('123')).thenThrow(IOException);
   var result=await remoteDataSource.getTrackingData('123') as ErrorResponse<TrackingModel>;
   expect(result.error,UnexpectedError());


 });
}
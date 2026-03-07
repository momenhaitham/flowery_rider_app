import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/tracking_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/use_case/get_tracking_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tracking_data_use_case_test.mocks.dart';
@GenerateMocks([TrackingRepoContract])
void main() {
  late TrackingRepoContract repo;
  late GetTrackingDataUseCase useCase;
  late final TrackingModel model;
  setUpAll(() {
    repo=MockTrackingRepoContract();
    useCase=GetTrackingDataUseCase(repo);
    model=TrackingModel(
      orderId: '123',
      orderState: 'delivered',
    );
  },);

  test('when calling get tracking data it must get data from repo', () async{
    provideDummy<BaseResponse<TrackingModel>>(SuccessResponse(data: model));
    when(repo.getTrackingData('123')).thenAnswer((_) async => Future.value(SuccessResponse(data: model)));
    var result=await useCase.invoke('123')as SuccessResponse<TrackingModel>;
    expect(result.data,model);
    verify(repo.getTrackingData('123')).called(1);
  });
}
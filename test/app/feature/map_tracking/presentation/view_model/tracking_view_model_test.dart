import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/use_case/get_tracking_data_use_case.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_intent.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tracking_view_model_test.mocks.dart';
@GenerateMocks([GetTrackingDataUseCase])
void main() {
  late GetTrackingDataUseCase useCase;
  late TrackingViewModel viewModel;
  late final TrackingModel model;
  setUpAll(() {
    useCase=MockGetTrackingDataUseCase();
    model=TrackingModel(
      orderId: '123',
      orderState: 'delivered',
    );
  },);
setUp(() {
  viewModel=TrackingViewModel(useCase);

},);
blocTest('when calling doIntent() with GetTrackingDataIntent with success it must emit correct state',
  setUp: () {
    provideDummy<BaseResponse<TrackingModel>>(SuccessResponse(data: model));
    when(useCase.invoke('123')).thenAnswer((_) async => Future.value(SuccessResponse(data: model)));
  },
  build: () => viewModel,
    act: (bloc) => bloc.doIntent(GetTrackingDataIntent('123')),
  expect: () {
    var state=viewModel.state;
    return [
      state.copyWith(trackingState: BaseState(isLoading: true)),
      state.copyWith(trackingState: BaseState(isLoading: false, data: model)),
    ];

  },
);
  blocTest('when calling doIntent() with GetTrackingDataIntent with error it must emit correct state',
    setUp: () {
      provideDummy<BaseResponse<TrackingModel>>(ErrorResponse(error: UnexpectedError()));
      when(useCase.invoke('123')).thenAnswer((_) async => Future.value(ErrorResponse(error: UnexpectedError())));
    },
    build: () => viewModel,
    act: (bloc) => bloc.doIntent(GetTrackingDataIntent('123')),
    expect: () {
      var state=viewModel.state;
      return [
        state.copyWith(trackingState: BaseState(isLoading: true)),
        state.copyWith(trackingState: BaseState(isLoading: false,error: UnexpectedError())),
      ];

    },
  );
}
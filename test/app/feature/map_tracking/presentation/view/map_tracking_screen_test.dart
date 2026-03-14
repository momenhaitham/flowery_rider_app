import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view/address_section.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view/map_tracking_screen.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_state.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'map_tracking_screen_test.mocks.dart';
@GenerateMocks([TrackingViewModel])
void main() {
  late TrackingViewModel viewModel;
  late GetIt getIt;
late TrackingModel trackingModel;
  buildWidget(){
    return MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => MapTrackingScreen(
            trackingId: '12345',
          ),
        );
      },
      home: MapTrackingScreen(
        trackingId: '12345',
      ),
    );
  }
  setUp(() {
    viewModel=MockTrackingViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<TrackingViewModel>()) {
      getIt.unregister<TrackingViewModel>();
    }
    getIt.registerSingleton<TrackingViewModel>(viewModel);
 trackingModel=TrackingModel(
   clientLat: '123',
   clientLong: '123',
   clientName: 'ahmed',
   storeName: 'flower'
 );
  },);
  testWidgets('test map tracking init state with loading',(widgetTester)async {
    when(viewModel.state).thenReturn(TrackingState(trackingState: BaseState(isLoading: true),
    userAddress: BaseState(),
    storeAddress: BaseState(),
    ));
    when(viewModel.stream).thenAnswer((_)=>Stream<TrackingState>.value(TrackingState(trackingState: BaseState(isLoading: true),
    userAddress: BaseState(),
    storeAddress: BaseState(),)));
    await widgetTester.pumpWidget(buildWidget());
    expect(find.byKey(Key('map_tracking_safe_area')),findsOneWidget);
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byKey(Key('map_tracking_loading_center')),findsOneWidget);
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
    },);
  testWidgets('test map tracking error state ',(widgetTester)async {
    when(viewModel.state).thenReturn(TrackingState(trackingState: BaseState(isLoading: false,
        error:UnexpectedError(
       'error'
    )),
      userAddress: BaseState(),
      storeAddress: BaseState(),
    ));
    when(viewModel.stream).thenAnswer((_)=>Stream<TrackingState>.value(TrackingState(trackingState: BaseState(isLoading: true),
      userAddress: BaseState(),
      storeAddress: BaseState(),)));
    await widgetTester.pumpWidget(buildWidget());
    expect(find.byKey(Key('map_tracking_safe_area')),findsOneWidget);
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byKey(Key('map_tracking_error_center')),findsOneWidget);
    expect(find.byType(Column),findsOneWidget);
    expect(find.byType(Text),findsNWidgets(2));
    expect(find.byType(ElevatedButton),findsOneWidget);
    expect(find.text('error'),findsOneWidget);
  },);
  testWidgets('test map tracking success state ',(widgetTester)async {
    widgetTester.view.physicalSize = const Size(1170, 2532);
    widgetTester.view.devicePixelRatio = 1.0;

    // Revert the size after the test to avoid affecting other tests
    addTearDown(widgetTester.view.resetPhysicalSize);
    when(viewModel.state).thenReturn(TrackingState(trackingState: BaseState(isLoading:false,
    data: trackingModel
    ),
      userAddress: BaseState(
          data: 'shikh zayed street'

      ),
      storeAddress: BaseState(
          data: 'haram street'

      ),
    ));
    when(viewModel.stream).thenAnswer((_)=>Stream<TrackingState>.value(TrackingState(trackingState: BaseState(isLoading: true),
      userAddress: BaseState(
      ),
      storeAddress: BaseState(
      ),)));
    await widgetTester.pumpWidget(buildWidget());
    expect(find.byKey(Key('map_tracking_safe_area')),findsOneWidget);
    expect(find.byKey(Key('map_tracking_stack')),findsOneWidget);
    expect(find.byKey(Key('map_tracking_back_button')),findsOneWidget);
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byType(FlutterMap),findsOneWidget);
    expect(find.byType(AddressSection),findsNWidgets(2));
    expect(find.byType(Icon),findsNWidgets(9));
    expect(find.byType(CircleAvatar),findsNWidgets(3));
    expect(find.text('ahmed'),findsOneWidget);
    expect(find.text('flower'),findsOneWidget);
    expect(find.text('shikh zayed street'),findsOneWidget);
    expect(find.text('haram street'),findsOneWidget);
    },);

}
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_states.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_viewmodel.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/screens/track_order_screen.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/order_details_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/track_order_indecator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'error_case_no_internet.mocks.dart';
import 'track_order_screen_test_setup.dart';




void main() {
  
    TestWidgetsFlutterBinding.ensureInitialized();

  late MockTrackOrderViewmodel mockedViewModel;
  final getItInstance = GetIt.instance;

  setUp(() async {
    await getItInstance.reset();

    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    mockedViewModel = MockTrackOrderViewmodel();

    getItInstance.registerFactory<TrackOrderViewmodel>(
      () => mockedViewModel,
    );
  });

  tearDown(() async {
    await getItInstance.reset();
  });


  Widget buildTrackOrderScreen(){
    
    return EasyLocalization(
    supportedLocales: const [Locale('ar'),Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: Builder(
      builder: (context) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: TrackOrderScreen(orderDetailsModel: TrackOrderScreenTestSetup.orderDetailsModel),
      ),
    ),
  );
  }


  testWidgets('track order screen with success state and Pick status delivery', (tester) async {
    
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
    });
    
    

    when(mockedViewModel.editOrderStateOnFireBase(2)).thenReturn(AppLocale.picked.tr());
    when(mockedViewModel.editDeliveryStatus(2)).thenReturn(AppLocale.startDeliver.tr());
    when(mockedViewModel.state).thenReturn(TrackOrderStates(
      orderState: BaseState(data: 2),
      getDriverDataState: BaseState(isLoading: false, error: null), // 👈 THIS IS THE FIX
    ));
    when(mockedViewModel.stream).thenAnswer((_) => Stream<TrackOrderStates>.fromIterable([
      TrackOrderStates(
        orderState: BaseState(data: 2),
        getDriverDataState: BaseState(isLoading: false, error: null), // 👈 AND HERE
      ),
    ]).asBroadcastStream());
    await tester.pumpWidget(buildTrackOrderScreen());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();
    
    var allText = tester.widgetList<Text>(find.byType(Text));
    for (var t in allText) {
    print('TEXT FOUND: "${t.data}"');
    }
    TrackOrderScreenTestSetup.findConstatntWidgets();
    expect(find.byType(Text),findsNWidgets(20));
    expect(find.byWidgetPredicate((widget) { 
      return widget is TrackOrderIndecatorWidget && widget.orderState == 2;
    },),findsNWidgets(1));
    expect(
      find.descendant(
        of: find.byType(TrackOrderIndecatorWidget),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).color == AppColors.successColor; 
        }),
      ),
      findsNWidgets(2),
    );
    expect(
      find.descendant(
        of: find.byType(OrderDetailsCard),
        matching: find.byWidgetPredicate((widget) {
          return widget is Text && widget.data == "${AppLocale.status.tr()} : ${AppLocale.picked}" && widget.style!.color == AppColors.successColor;
        }),
      ),
      findsOneWidget,
    );
    
    expect(find.byWidgetPredicate((widget) { 
      return widget is OrderDetailsCard && widget.state == AppLocale.picked;
    },),findsNWidgets(1));

    expect(find.byWidgetPredicate((widget) {
      return widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == AppLocale.startDeliver;
    },),findsNWidgets(1));
    await getItInstance.reset();
    await tester.pump(const Duration(seconds: 11)); 
  });
  
}


// "${AppLocale.status.tr()} : ${AppLocale.accepted}"
//"Exception: no internet"
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/meta_data_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_states.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_view_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/screen/home_tab.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_tab_test.mocks.dart';

@GenerateMocks([HomeTabViewModel])
void main() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late MockHomeTabViewModel mockHomeTabViewModel;
  late GetIt getIt;
  setUp(() {
    mockHomeTabViewModel = MockHomeTabViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<HomeTabViewModel>()) {
      getIt.unregister<HomeTabViewModel>();
    }
    getIt.registerSingleton<HomeTabViewModel>(mockHomeTabViewModel);
    when(mockHomeTabViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockHomeTabViewModel.state).thenReturn(
      HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(isLoading: false),
      ),
    );
    when(mockHomeTabViewModel.doIntent(any)).thenAnswer((_) {});
  });
  tearDown(() {
    if (getIt.isRegistered<HomeTabViewModel>()) {
      getIt.unregister<HomeTabViewModel>();
    }
  });
  Widget buildTestableWidget() {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == Routes.trackOrder) {
          return MaterialPageRoute(
            builder: (context) =>
                Center(child: Text('Track Order Test Screen')),
          );
        }
        return MaterialPageRoute(builder: (context) => HomeTab());
      },
      home: HomeTab(),
    );
  }

  testWidgets('home tab loading state', (WidgetTester tester) async {
    when(mockHomeTabViewModel.state).thenReturn(
      HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: true,
          data: [],
        ),
        rejectedOrderIds: {},
      ),
    );
    when(mockHomeTabViewModel.stream).thenAnswer(
      (_) => Stream<HomeTabStates>.value(
        HomeTabStates(
          ordersState: BaseState<List<OrderDetailsModel>>(
            isLoading: true,
            data: [],
          ),
          rejectedOrderIds: {},
        ),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(AppLocale.flowery_rider.tr()), findsOneWidget);
    expect(find.byType(OrderCardWidget), findsNothing);
  });
  testWidgets('HomeTab error state', (WidgetTester tester) async {
    final errorMessage = 'Server connection failed';
    final dummyException = ServerError(message: errorMessage);
    when(mockHomeTabViewModel.state).thenReturn(
      HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: false,
          error: dummyException,
        ),
      ),
    );
    when(mockHomeTabViewModel.stream).thenAnswer(
      (_) => Stream<HomeTabStates>.value(
        HomeTabStates(
          ordersState: BaseState<List<OrderDetailsModel>>(
            isLoading: false,
            error: dummyException,
          ),
        ),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text(AppLocale.flowery_rider.tr()), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
    expect(find.byType(OrderCardWidget), findsNothing);
  });
  testWidgets('HomeTab success state with empty order list', (
    WidgetTester tester,
  ) async {
    when(mockHomeTabViewModel.state).thenReturn(
      HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: false,
          data: [],
        ),
        rejectedOrderIds: {},
      ),
    );
    when(mockHomeTabViewModel.stream).thenAnswer(
      (_) => Stream<HomeTabStates>.value(
        HomeTabStates(
          ordersState: BaseState<List<OrderDetailsModel>>(
            isLoading: false,
            data: [],
          ),
          rejectedOrderIds: {},
        ),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text(AppLocale.flowery_rider.tr()), findsOneWidget);
    expect(find.text(AppLocale.noPendingOrders.tr()), findsOneWidget);
    expect(find.byType(OrderCardWidget), findsNothing);
  });
  testWidgets('HomeTab success state with a list of orders(initial load)', (WidgetTester tester) async{
    final dummyRes=GetPendingOrdersResponseModel(
      metadata: MetaDataModel(currentPage: 1,limit: 3,totalItems: 10,totalPages: 4),
      orders: [
        OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
        OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
      ]
    );
    final orders = dummyRes.orders;
    final metadata = dummyRes.metadata;
    final totalItems = metadata?.totalItems ?? orders?.length;
    final hasMoreData = orders!.length < totalItems!;
    when(mockHomeTabViewModel.state).thenReturn(HomeTabStates(
      ordersState: BaseState<List<OrderDetailsModel>>(
        isLoading: true,
        data: orders
      ),
      metaData: metadata,
      hasMoreData: hasMoreData
    ));
    when(mockHomeTabViewModel.stream).thenAnswer(
      (_) =>Stream<HomeTabStates>.value(HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: true,
          data: orders
        ),
        metaData: metadata,
        hasMoreData: hasMoreData
      )) ,
    );
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.text(AppLocale.flowery_rider.tr()), findsOneWidget);
    expect(find.text(AppLocale.noPendingOrders.tr()), findsNothing);
    expect(find.byType(OrderCardWidget), findsNWidgets(2));
  },);
}
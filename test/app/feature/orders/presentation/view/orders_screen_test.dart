// test/app/feature/orders/presentation/view/orders_screen_test.dart
//
// CustomCubit<OrdersEvent, OrdersState> extends Cubit<OrdersState>
// → BlocProvider<OrdersViewModel>.value() is valid ✓
// Mock's streamController is StreamController<OrdersEvent> (typed correctly now)

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_order_entity.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view/orders_screen.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_event.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_intent.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_state.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_view_model.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/widgets/order_list_card.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/widgets/orders_summary_card.dart';

import 'orders_screen_test.mocks.dart';

@GenerateMocks([OrdersViewModel])
void main() {
  late MockOrdersViewModel mockViewModel;

  // ── Helpers ───────────────────────────────────────────────────────────────

  DriverOrderEntity buildFakeOrder({String state = 'completed'}) =>
      DriverOrderEntity(
        id: 'order-id-1',
        driverId: 'driver-id-1',
        order: OrderEntity(
          id: 'nested-order-id-1',
          orderNumber: '#123456',
          state: state,
          totalPrice: 250.0,
          paymentType: 'cash',
          isPaid: false,
          isDelivered: false,
          user: const OrderUserEntity(
            id: 'user-id-1',
            firstName: 'Nour',
            lastName: 'Mohamed',
            photo: 'default-profile.png',
            phone: '+201010700999',
          ),
          orderItems: const [],
          createdAt: DateTime(2025, 1, 17),
        ),
        store: const OrderStoreEntity(
          name: 'Elevate FlowerApp Store',
          image: 'https://www.elevateegy.com/elevate.png',
          address: '123 Fixed Address',
          phoneNumber: '1234567890',
          latLong: '37.7749,-122.4194',
        ),
        createdAt: DateTime(2025, 1, 17),
      );

  Widget buildWidget(MockOrdersViewModel vm, OrdersState initialState) {
    // streamController<OrdersEvent> — typed stream for navigation events
    final eventController = StreamController<OrdersEvent>.broadcast();
    when(vm.streamController).thenReturn(eventController);
    when(vm.state).thenReturn(initialState);
    // stream is the Cubit<OrdersState> state stream
    when(vm.stream).thenAnswer((_) => Stream.fromIterable([initialState]));
    when(vm.doIntent(any)).thenReturn(null);

    if (!GetIt.instance.isRegistered<OrdersViewModel>()) {
      GetIt.instance.registerFactory<OrdersViewModel>(() => vm);
    }

    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: BlocProvider<OrdersViewModel>.value(
            value: vm,
            child: const OrdersScreen(),
          ),
        ),
      ),
    );
  }

  // ── All scenarios in one testWidgets (EasyLocalization re-init workaround) ─

  testWidgets('OrdersScreen — comprehensive widget test', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    mockViewModel = MockOrdersViewModel();

    // ── Scenario 1: Loading ───────────────────────────────────────────────
    final loadingState = OrdersState(ordersState: BaseState(isLoading: true));
    await tester.pumpWidget(buildWidget(mockViewModel, loadingState));
    await tester.pump();

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
      reason: 'Should show spinner while loading',
    );

    // ── Scenario 2: Success — 2 orders ────────────────────────────────────
    GetIt.instance.reset();
    mockViewModel = MockOrdersViewModel();

    final orders = [
      buildFakeOrder(state: 'completed'),
      buildFakeOrder(state: 'canceled'),
    ];
    final successState = OrdersState(
      ordersState: BaseState(data: orders),
      currentPage: 1,
      totalPages: 5,
    );
    await tester.pumpWidget(buildWidget(mockViewModel, successState));
    await tester.pumpAndSettle();

    expect(find.byType(OrdersSummaryCard), findsNWidgets(2));
    expect(find.byType(OrderListCard), findsNWidgets(2));
    expect(find.text('#123456'), findsWidgets);

    // ── Scenario 3: Tap → NavigateToOrderDetailsIntent dispatched ─────────
    GetIt.instance.reset();
    mockViewModel = MockOrdersViewModel();

    await tester.pumpWidget(buildWidget(mockViewModel, successState));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(OrderListCard).first);
    await tester.pump();

    verify(
      mockViewModel.doIntent(argThat(isA<NavigateToOrderDetailsIntent>())),
    ).called(1);

    // ── Scenario 4: Empty ─────────────────────────────────────────────────
    GetIt.instance.reset();
    mockViewModel = MockOrdersViewModel();

    final emptyState = OrdersState(ordersState: BaseState(data: const []));
    await tester.pumpWidget(buildWidget(mockViewModel, emptyState));
    await tester.pumpAndSettle();

    expect(find.byType(OrderListCard), findsNothing);

    // ── Scenario 5: Error → Retry → LoadOrdersIntent ──────────────────────
    GetIt.instance.reset();
    mockViewModel = MockOrdersViewModel();

    final errorState = OrdersState(
      ordersState: BaseState(error: Exception('Network error')),
    );
    await tester.pumpWidget(buildWidget(mockViewModel, errorState));
    await tester.pumpAndSettle();

    expect(find.text('Retry'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pump();

    verify(mockViewModel.doIntent(argThat(isA<LoadOrdersIntent>()))).called(1);

    GetIt.instance.reset();
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_order_entity.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_orders_result.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/use_case/get_driver_orders_use_case.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_event.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_intent.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_state.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view_model/orders_view_model.dart';

import 'orders_view_model_test.mocks.dart';

@GenerateMocks([GetDriverOrdersUseCase])
void main() {
  late OrdersViewModel viewModel;
  late MockGetDriverOrdersUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetDriverOrdersUseCase();
    viewModel = OrdersViewModel(mockUseCase);
  });

  tearDown(() => viewModel.close());

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

  DriverOrdersResult buildFakeResult({
    List<DriverOrderEntity>? orders,
    int totalPages = 17,
    int currentPage = 1,
  }) => DriverOrdersResult(
    orders: orders ?? [buildFakeOrder()],
    totalPages: totalPages,
    currentPage: currentPage,
  );

  group('LoadOrdersIntent', () {
    blocTest<OrdersViewModel, OrdersState>(
      'emits [loading, data] and sets totalPages on success',
      build: () {
        when(mockUseCase.call(page: 1)).thenAnswer(
          (_) async => SuccessResponse(data: buildFakeResult(totalPages: 17)),
        );
        return viewModel;
      },
      act: (vm) => vm.doIntent(LoadOrdersIntent(page: 1)),
      expect: () => [
        isA<OrdersState>().having((s) => s.isLoading, 'isLoading', isTrue),
        isA<OrdersState>()
            .having((s) => s.isLoading, 'isLoading', isFalse)
            .having((s) => s.hasData, 'hasData', isTrue)
            .having((s) => s.orders.length, 'orders.length', 1)
            .having((s) => s.totalPages, 'totalPages', 17),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'emits [loading, error] when use case fails',
      build: () {
        when(mockUseCase.call(page: 1)).thenAnswer(
          (_) async => ErrorResponse(error: Exception('Server error')),
        );
        return viewModel;
      },
      act: (vm) => vm.doIntent(LoadOrdersIntent(page: 1)),
      expect: () => [
        isA<OrdersState>().having((s) => s.isLoading, 'isLoading', isTrue),
        isA<OrdersState>()
            .having((s) => s.hasError, 'hasError', isTrue)
            .having((s) => s.hasData, 'hasData', isFalse),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'cancelledCount and completedCount computed correctly',
      build: () {
        when(mockUseCase.call(page: 1)).thenAnswer(
          (_) async => SuccessResponse(
            data: buildFakeResult(
              orders: [
                buildFakeOrder(state: 'canceled'),
                buildFakeOrder(state: 'canceled'),
                buildFakeOrder(state: 'completed'),
                buildFakeOrder(state: 'pending'),
              ],
            ),
          ),
        );
        return viewModel;
      },
      act: (vm) => vm.doIntent(LoadOrdersIntent(page: 1)),
      verify: (vm) {
        expect(vm.state.cancelledCount, equals(2));
        expect(vm.state.completedCount, equals(1));
      },
    );
  });

  group('LoadMoreOrdersIntent', () {
    blocTest<OrdersViewModel, OrdersState>(
      'appends new orders and advances page',
      build: () {
        when(mockUseCase.call(page: 2)).thenAnswer(
          (_) async => SuccessResponse(
            data: buildFakeResult(
              orders: [buildFakeOrder(state: 'canceled')],
              totalPages: 17,
              currentPage: 2,
            ),
          ),
        );
        return viewModel;
      },
      seed: () => OrdersState(
        ordersState: BaseState(data: [buildFakeOrder()]),
        currentPage: 1,
        totalPages: 17,
      ),
      act: (vm) => vm.doIntent(LoadMoreOrdersIntent()),
      expect: () => [
        isA<OrdersState>().having(
          (s) => s.isLoadingMore,
          'isLoadingMore',
          isTrue,
        ),
        isA<OrdersState>()
            .having((s) => s.isLoadingMore, 'isLoadingMore', isFalse)
            .having((s) => s.orders.length, 'orders.length', 2)
            .having((s) => s.currentPage, 'currentPage', 2),
      ],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'does nothing when already on last page',
      build: () => viewModel,
      seed: () => OrdersState(
        ordersState: BaseState(data: [buildFakeOrder()]),
        currentPage: 17,
        totalPages: 17,
      ),
      act: (vm) => vm.doIntent(LoadMoreOrdersIntent()),
      expect: () => [],
    );

    blocTest<OrdersViewModel, OrdersState>(
      'does nothing when already loading more',
      build: () => viewModel,
      seed: () => OrdersState(
        ordersState: BaseState(data: [buildFakeOrder()]),
        currentPage: 1,
        totalPages: 17,
        isLoadingMore: true,
      ),
      act: (vm) => vm.doIntent(LoadMoreOrdersIntent()),
      expect: () => [],
    );
  });

  group('NavigateToOrderDetailsIntent', () {
    test('adds NavigateToOrderDetailsEvent to streamController', () async {
      final order = buildFakeOrder();
      expectLater(
        viewModel.streamController.stream,
        emits(
          isA<NavigateToOrderDetailsEvent>().having(
            (e) => e.order.id,
            'order.id',
            order.id,
          ),
        ),
      );
      viewModel.doIntent(NavigateToOrderDetailsIntent(order: order));
    });
  });
}

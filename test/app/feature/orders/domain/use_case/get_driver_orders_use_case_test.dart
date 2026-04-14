import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_order_entity.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_orders_result.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/orders_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/use_case/get_driver_orders_use_case.dart';

import 'get_driver_orders_use_case_test.mocks.dart';

@GenerateMocks([OrdersRepoContract])
void main() {
  late GetDriverOrdersUseCase useCase;
  late MockOrdersRepoContract mockRepo;

  setUp(() {
    mockRepo = MockOrdersRepoContract();
    useCase = GetDriverOrdersUseCase(mockRepo);
  });

  DriverOrderEntity _fakeOrder({String state = 'completed'}) =>
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
          orderItems: [],
          createdAt: DateTime(2025, 1, 17),
        ),
        store: const OrderStoreEntity(
          name: 'Elevate FlowerApp Store',
          image: 'https://www.elevateegy.com/elevate.png',
          address: '123 Fixed Address, City, Country',
          phoneNumber: '1234567890',
          latLong: '37.7749,-122.4194',
        ),
        createdAt: DateTime(2025, 1, 17),
      );

  DriverOrdersResult _resultWith({
    required List<DriverOrderEntity> orders,
    int totalPages = 3,
    int currentPage = 1,
  }) {
    return DriverOrdersResult(
      orders: orders,
      totalPages: totalPages,
      currentPage: currentPage,
    );
  }

  group('GetDriverOrdersUseCase', () {
    test(
      'should return DriverOrdersResult with list of DriverOrderEntity when repo succeeds',
      () async {
        final orders = [_fakeOrder(), _fakeOrder(state: 'canceled')];
        when(
          mockRepo.getDriverOrders(page: 1),
        ).thenAnswer(
          (_) async => SuccessResponse<DriverOrdersResult>(
            data: _resultWith(orders: orders, totalPages: 5, currentPage: 1),
          ),
        );

        final result = await useCase.call(page: 1);

        expect(result, isA<SuccessResponse<DriverOrdersResult>>());
        final data = (result as SuccessResponse<DriverOrdersResult>).data;
        expect(data.orders.length, equals(2));
        expect(data.totalPages, equals(5));
        expect(data.currentPage, equals(1));
        verify(mockRepo.getDriverOrders(page: 1)).called(1);
        verifyNoMoreInteractions(mockRepo);
      },
    );

    test('should pass correct page number to repo', () async {
      when(
        mockRepo.getDriverOrders(page: 3),
      ).thenAnswer(
        (_) async => SuccessResponse<DriverOrdersResult>(
          data: _resultWith(orders: [_fakeOrder()], currentPage: 3),
        ),
      );

      await useCase.call(page: 3);

      verify(mockRepo.getDriverOrders(page: 3)).called(1);
    });

    test('should return ErrorResponse when repo fails', () async {
      final exception = Exception('Network error');
      when(
        mockRepo.getDriverOrders(page: 1),
      ).thenAnswer(
        (_) async => ErrorResponse<DriverOrdersResult>(error: exception),
      );

      final result = await useCase.call(page: 1);

      expect(result, isA<ErrorResponse<DriverOrdersResult>>());
    });

    test('should return empty list when repo returns empty list', () async {
      when(
        mockRepo.getDriverOrders(page: 1),
      ).thenAnswer(
        (_) async => SuccessResponse<DriverOrdersResult>(
          data: _resultWith(orders: const [], totalPages: 1, currentPage: 1),
        ),
      );

      final result = await useCase.call(page: 1);

      expect(result, isA<SuccessResponse<DriverOrdersResult>>());
      final data = (result as SuccessResponse<DriverOrdersResult>).data;
      expect(data.orders, isEmpty);
      expect(data.totalPages, equals(1));
      expect(data.currentPage, equals(1));
    });

    test('should use page 1 as default when no page is specified', () async {
      when(
        mockRepo.getDriverOrders(page: 1),
      ).thenAnswer(
        (_) async => SuccessResponse<DriverOrdersResult>(
          data: _resultWith(orders: const [], totalPages: 1, currentPage: 1),
        ),
      );

      await useCase.call();

      verify(mockRepo.getDriverOrders(page: 1)).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/orders/data/model/driver_orders_response.dart';
import 'package:flowery_rider_app/app/feature/orders/data/orders_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/orders/data/orders_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_orders_result.dart';

import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersDataSourceContract])
void main() {
  late OrdersRepoImpl repo;
  late MockOrdersDataSourceContract mockDataSource;

  setUp(() {
    mockDataSource = MockOrdersDataSourceContract();
    repo = OrdersRepoImpl(mockDataSource);
  });

  DriverOrdersResponseDto buildFakeDto({
    int page = 1,
    String state = 'completed',
  }) => DriverOrdersResponseDto(
    message: 'success',
    metadata: MetadataDto(
      currentPage: page,
      totalPages: 17,
      totalItems: 169,
      limit: 10,
    ),
    orders: [
      DriverOrderDto(
        id: 'wrapper-id-1',
        driver: 'driver-id-1',
        order: DriverOrderNestedDto(
          id: 'order-id-1',
          orderNumber: '#123451',
          state: state,
          totalPrice: 250.0,
          paymentType: 'cash',
          isPaid: false,
          isDelivered: false,
          user: const OrderUserDtoModel(
            id: 'user-id-1',
            firstName: 'Elevate',
            lastName: 'Tech',
            photo: 'default-profile.png',
            phone: '+201010700999',
          ),
          orderItems: const [
            OrderItemDtoModel(
              product: OrderItemProductDto(
                id: '673e1cd711599201718280fb',
                price: 250.0,
                title: null,
              ),
              price: 250.0,
              quantity: 2,
            ),
          ],
          createdAt: '2025-01-17T18:04:38.730Z',
        ),
        store: const OrderStoreDtoModel(
          name: 'Elevate FlowerApp Store',
          image: 'https://www.elevateegy.com/elevate.png',
          address: '123 Fixed Address, City, Country',
          phoneNumber: '1234567890',
          latLong: '37.7749,-122.4194',
        ),
        createdAt: '2025-01-17T19:53:00.933Z',
      ),
    ],
  );

  group('OrdersRepoImpl', () {
    test(
      'returns SuccessResponse with DriverOrdersResult on success',
      () async {
        when(
          mockDataSource.getDriverOrders(page: 1),
        ).thenAnswer((_) async => buildFakeDto());

        final result = await repo.getDriverOrders(page: 1);

        expect(result, isA<SuccessResponse<DriverOrdersResult>>());
        final data = (result as SuccessResponse<DriverOrdersResult>).data;
        expect(data.orders.length, equals(1));
        expect(data.totalPages, equals(17));
        expect(data.currentPage, equals(1));
      },
    );

    test('maps DTO fields to entity correctly', () async {
      when(
        mockDataSource.getDriverOrders(page: 1),
      ).thenAnswer((_) async => buildFakeDto(state: 'canceled'));

      final result = await repo.getDriverOrders(page: 1);

      final data = (result as SuccessResponse<DriverOrdersResult>).data;
      final order = data.orders.first;
      expect(order.id, equals('wrapper-id-1'));
      expect(order.order.orderNumber, equals('#123451'));
      expect(order.order.isCanceled, isTrue);
      expect(order.order.user.fullName, equals('Elevate Tech'));
      expect(order.store.name, equals('Elevate FlowerApp Store'));
    });

    test('title is null in order items (not returned by API)', () async {
      when(
        mockDataSource.getDriverOrders(page: 1),
      ).thenAnswer((_) async => buildFakeDto());

      final result = await repo.getDriverOrders(page: 1);
      final data = (result as SuccessResponse<DriverOrdersResult>).data;
      expect(data.orders.first.order.orderItems.first.title, isNull);
    });

    test('returns ErrorResponse when data source throws', () async {
      when(
        mockDataSource.getDriverOrders(page: 1),
      ).thenThrow(Exception('Server error'));

      final result = await repo.getDriverOrders(page: 1);
      expect(result, isA<ErrorResponse<DriverOrdersResult>>());
    });

    test('passes correct page number to data source', () async {
      when(
        mockDataSource.getDriverOrders(page: 2),
      ).thenAnswer((_) async => buildFakeDto(page: 2));

      await repo.getDriverOrders(page: 2);
      verify(mockDataSource.getDriverOrders(page: 2)).called(1);
    });
  });
}

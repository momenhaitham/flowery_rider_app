import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/repos/home_tab_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/meta_data_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/use_cases/home_tab_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'home_tab_use_case_test.mocks.dart';

@GenerateMocks([HomeTabRepoImpl])
void main() { 
  late HomeTabUseCase homeTabUseCase;
  late MockHomeTabRepoImpl mockHomeTabRepoImpl;
  setUpAll(() {
    provideDummy<BaseResponse<GetPendingOrdersResponseModel>>(SuccessResponse<GetPendingOrdersResponseModel>(data: GetPendingOrdersResponseModel()));
    mockHomeTabRepoImpl=MockHomeTabRepoImpl();
    homeTabUseCase=HomeTabUseCase(mockHomeTabRepoImpl); 
  },);
  group('HomeTabUseCase test cases', () {
    test('checking that call() function works properly', () async{
      final initialLimit=3;
      final dummyRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(currentPage: 1,limit: initialLimit,totalItems: 300,totalPages: 100),
        orders: [
            OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
            OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2')
        ]
      );
      when(mockHomeTabRepoImpl.getOrders(initialLimit)).thenAnswer(
        (_) async=> SuccessResponse<GetPendingOrdersResponseModel>(data: dummyRes),
      );
      final result=await homeTabUseCase.call(initialLimit);
      expect(result, isA<SuccessResponse<GetPendingOrdersResponseModel>>());
      expect((result as SuccessResponse<GetPendingOrdersResponseModel>).data.metadata?.currentPage, equals(dummyRes.metadata?.currentPage));
      expect(result.data.metadata?.limit, equals(dummyRes.metadata?.limit));
      expect(result.data.metadata?.totalItems, equals(dummyRes.metadata?.totalItems));
      expect(result.data.metadata?.totalPages, equals(dummyRes.metadata?.totalPages));
      expect(result.data.orders?.length, equals(dummyRes.orders?.length));
      expect(result.data.orders![0].orderId, equals(dummyRes.orders![0].orderId));
      expect(result.data.orders![0].orderNumber, equals(dummyRes.orders![0].orderNumber));
      expect(result.data.orders![1].orderId, equals(dummyRes.orders![1].orderId));
      expect(result.data.orders![1].orderNumber, equals(dummyRes.orders![1].orderNumber));
      verify(mockHomeTabRepoImpl.getOrders(initialLimit)).called(1);
    },);
    test('testing failure case with error', () async{
      final initialLimit=3;
      final dummyException=Exception("Network Error");
      when(mockHomeTabRepoImpl.getOrders(initialLimit)).thenAnswer(
        (_) async=> ErrorResponse<GetPendingOrdersResponseModel>(error: dummyException),
      );
      final result=await homeTabUseCase.call(initialLimit);
      expect(result, isA<ErrorResponse<GetPendingOrdersResponseModel>>());
      expect((result as ErrorResponse<GetPendingOrdersResponseModel>).error.toString(), equals(dummyException.toString()));
      verify(mockHomeTabRepoImpl.getOrders(initialLimit)).called(1);
    },);
  },);
}
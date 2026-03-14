import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/api/datasources/remote/home_tab_remote_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/get_pending_orders_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/meta_data_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_details_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/repos/home_tab_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'home_tab_repo_impl_test.mocks.dart';

@GenerateMocks([HomeTabRemoteDataSourceImpl])
void main() {
  late HomeTabRepoImpl homeTabRepoImpl;
  late MockHomeTabRemoteDataSourceImpl mockHomeTabRemoteDataSourceImpl;
  setUpAll(() {
    provideDummy<BaseResponse<GetPendingOrdersResponse>>(SuccessResponse<GetPendingOrdersResponse>(data: GetPendingOrdersResponse()));
    mockHomeTabRemoteDataSourceImpl=MockHomeTabRemoteDataSourceImpl();
    homeTabRepoImpl=HomeTabRepoImpl(mockHomeTabRemoteDataSourceImpl);
  },);
  group('HomeTabRepoImpl test cases', () {
    test('success case', () async{
      final initialLimit=3;
      final dummyRes=GetPendingOrdersResponse(
        metadata: MetadataDTO(currentPage: 1,limit: initialLimit,totalItems: 300,totalPages: 100),
        orders: [
          OrderDetailsDTO(id: 'id1',orderNumber: 'orderNo1'),
          OrderDetailsDTO(id: 'id2',orderNumber: 'orderNo2')
        ]
      );
      when(mockHomeTabRemoteDataSourceImpl.getPendingOrders(initialLimit)).thenAnswer(
        (_) async=>SuccessResponse<GetPendingOrdersResponse>(data: dummyRes) ,
      );
      final result=await homeTabRepoImpl.getOrders(initialLimit);
      expect(result, isA<SuccessResponse<GetPendingOrdersResponseModel>>());
      expect((result as SuccessResponse<GetPendingOrdersResponseModel>).data.metadata?.currentPage, equals(dummyRes.metadata?.currentPage));
      expect(result.data.orders?.length, equals(dummyRes.orders?.length));
      expect(result.data.orders![0].orderId, equals(dummyRes.orders![0].id));
      expect(result.data.orders![0].orderNumber, equals(dummyRes.orders![0].orderNumber));
      expect(result.data.orders![1].orderId, equals(dummyRes.orders![1].id));
      expect(result.data.orders![1].orderNumber, equals(dummyRes.orders![1].orderNumber));
      verify(mockHomeTabRemoteDataSourceImpl.getPendingOrders(initialLimit)).called(1);
    },);
    test('error case', () async{
      final initialLimit=3;
      final dummyException=Exception("Network Error");
      when(mockHomeTabRemoteDataSourceImpl.getPendingOrders(initialLimit)).thenAnswer(
        (_) async=>ErrorResponse<GetPendingOrdersResponse>(error: dummyException) ,
      );
      final result=await homeTabRepoImpl.getOrders(initialLimit);
      expect(result, isA<ErrorResponse<GetPendingOrdersResponseModel>>());
      expect((result as ErrorResponse<GetPendingOrdersResponseModel>).error.toString(), equals(dummyException.toString()));
      verify(mockHomeTabRemoteDataSourceImpl.getPendingOrders(initialLimit)).called(1);
    },);
  },);
}
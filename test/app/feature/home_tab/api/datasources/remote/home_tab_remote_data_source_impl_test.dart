import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/api/api_client/home_tab_api_client.dart';
import 'package:flowery_rider_app/app/feature/home_tab/api/datasources/remote/home_tab_remote_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/get_pending_orders_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_details_dto.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'home_tab_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeTabApiClient])
void main() {
  late HomeTabRemoteDataSourceImpl homeTabRemoteDataSourceImpl;
  late MockHomeTabApiClient mockHomeTabApiClient;
  setUpAll(() {
    mockHomeTabApiClient=MockHomeTabApiClient();
    homeTabRemoteDataSourceImpl=HomeTabRemoteDataSourceImpl(mockHomeTabApiClient);
  },);
  
  test('testing functionality of getPendingOrders function', () async{
    final int dummyLimit=3;
    final dummyRes=GetPendingOrdersResponse(
      message: "success",
      orders: [OrderDetailsDTO(id: 'id1'),OrderDetailsDTO(id: 'id2')]
    );
    when(mockHomeTabApiClient.getPendingOrders(dummyLimit)).thenAnswer(
      (_) async=>dummyRes ,
    );
    final result=await homeTabRemoteDataSourceImpl.getPendingOrders(dummyLimit);
    expect(result, isA<BaseResponse<GetPendingOrdersResponse>>());
    expect((result as SuccessResponse<GetPendingOrdersResponse>).data.message, equals(dummyRes.message));
    expect(result.data.orders?.length, equals(dummyRes.orders?.length));
    expect(result.data.orders![0].id, equals(dummyRes.orders![0].id));
    expect(result.data.orders![1].id, equals(dummyRes.orders![1].id));
    verify(mockHomeTabApiClient.getPendingOrders(dummyLimit)).called(1);
  },);
}
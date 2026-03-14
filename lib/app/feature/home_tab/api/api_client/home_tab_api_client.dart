import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/core/consts/app_consts.dart';
import 'package:flowery_rider_app/app/core/endpoint/app_endpoint.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/get_pending_orders_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'home_tab_api_client.g.dart';
@injectable
@RestApi()
abstract class HomeTabApiClient {
  @factoryMethod
  factory HomeTabApiClient(Dio dio)=_HomeTabApiClient;
  @GET(AppEndPoint.ordersPending)
  Future<GetPendingOrdersResponse> getPendingOrders(
    @Query(AppConsts.limitKey) int? limit
  );
}
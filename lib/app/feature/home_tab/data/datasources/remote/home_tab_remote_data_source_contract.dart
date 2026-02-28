import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/get_pending_orders_response.dart';

abstract class HomeTabRemoteDataSourceContract {
  Future<BaseResponse<GetPendingOrdersResponse>> getPendingOrders(int? limit);
}
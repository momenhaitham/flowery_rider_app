import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';

abstract class HomeTabRepoContract {
  Future<BaseResponse<GetPendingOrdersResponseModel>> getOrders(int? limit);
}
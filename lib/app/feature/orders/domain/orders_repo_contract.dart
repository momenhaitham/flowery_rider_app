import '../../../config/base_response/base_response.dart';
import 'model/driver_orders_result.dart';

abstract class OrdersRepoContract {
  Future<BaseResponse<DriverOrdersResult>> getDriverOrders({int page = 1});
}

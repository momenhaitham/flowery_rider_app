import 'model/driver_orders_response.dart';

abstract class OrdersDataSourceContract {
  Future<DriverOrdersResponseDto> getDriverOrders({int page = 1});
}

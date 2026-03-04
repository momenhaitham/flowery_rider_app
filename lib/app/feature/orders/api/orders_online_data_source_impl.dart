import 'package:injectable/injectable.dart';
import '../data/model/driver_orders_response.dart';
import '../data/orders_data_source_contract.dart';
import 'orders_api_client.dart';

@Injectable(as: OrdersDataSourceContract)
class OrdersOnlineDataSourceImpl implements OrdersDataSourceContract {
  final OrdersApiClient _apiClient;

  OrdersOnlineDataSourceImpl(this._apiClient);

  @override
  Future<DriverOrdersResponseDto> getDriverOrders({int page = 1}) {
    return _apiClient.getDriverOrders(page);
  }
}

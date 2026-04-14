import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_orders_result.dart';
import 'package:injectable/injectable.dart';
import '../../../config/api_utils/api_utils.dart';
import '../../../config/base_response/base_response.dart';
import '../domain/orders_repo_contract.dart';
import 'orders_data_source_contract.dart';

@Injectable(as: OrdersRepoContract)
class OrdersRepoImpl implements OrdersRepoContract {
  final OrdersDataSourceContract _dataSource;

  OrdersRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<DriverOrdersResult>> getDriverOrders({int page = 1}) {
    return executeApi(() async {
      final response = await _dataSource.getDriverOrders(page: page);
      return DriverOrdersResult(
        orders: response.orders.map((dto) => dto.toEntity()).toList(),
        totalPages: response.metadata.totalPages,
        currentPage: response.metadata.currentPage,
      );
    });
  }
}

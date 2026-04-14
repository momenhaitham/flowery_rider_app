import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../model/driver_orders_result.dart';
import '../orders_repo_contract.dart';

@injectable
class GetDriverOrdersUseCase {
  final OrdersRepoContract _repo;

  GetDriverOrdersUseCase(this._repo);

  Future<BaseResponse<DriverOrdersResult>> call({int page = 1}) {
    return _repo.getDriverOrders(page: page);
  }
}

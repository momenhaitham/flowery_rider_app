import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/repos/home_tab_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeTabUseCase {
  final HomeTabRepoContract _homeTabRepoContract;
  HomeTabUseCase(this._homeTabRepoContract);
  Future<BaseResponse<GetPendingOrdersResponseModel>> call(int? limit) async{
    return _homeTabRepoContract.getOrders(limit);
  }
}
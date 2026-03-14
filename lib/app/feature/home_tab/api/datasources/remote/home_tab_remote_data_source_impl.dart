import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/api/api_client/home_tab_api_client.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/datasources/remote/home_tab_remote_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/get_pending_orders_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: HomeTabRemoteDataSourceContract)
class HomeTabRemoteDataSourceImpl implements HomeTabRemoteDataSourceContract{
  final HomeTabApiClient _apiClient;
  HomeTabRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<GetPendingOrdersResponse>> getPendingOrders(int? limit) {
    return executeApi(() => _apiClient.getPendingOrders(limit),);
  }
}
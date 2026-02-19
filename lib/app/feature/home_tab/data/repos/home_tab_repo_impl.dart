import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/datasources/remote/home_tab_remote_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/get_pending_orders_response.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/repos/home_tab_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: HomeTabRepoContract)
class HomeTabRepoImpl implements HomeTabRepoContract{
  final HomeTabRemoteDataSourceContract _dataSourceContract;
  HomeTabRepoImpl(this._dataSourceContract);

  @override
  Future<BaseResponse<GetPendingOrdersResponseModel>> getOrders(int? limit) async{
    final response = await _dataSourceContract.getPendingOrders(limit);
    switch(response){
      
      case SuccessResponse<GetPendingOrdersResponse>():
        final pendingRes=response.data.toDomain();
        return SuccessResponse<GetPendingOrdersResponseModel>(data: pendingRes);
      case ErrorResponse<GetPendingOrdersResponse>():
        return ErrorResponse<GetPendingOrdersResponseModel>(error: response.error);
    }
  }
}
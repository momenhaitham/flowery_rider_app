import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/apply_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/apply_driver_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ApplyDriverRepoContract)
class ApplyDriverRepoImpl  extends ApplyDriverRepoContract{
  final ApplyDataSourceContract _applyDataSourceContract;

  ApplyDriverRepoImpl(this._applyDataSourceContract);

  @override
  Future<BaseResponse<String>> applyDriver(ApplyDriverRequest request)async {
    final result =await _applyDataSourceContract.applyDriver(request);
    switch(result){
      case SuccessResponse():
        return SuccessResponse(data: result.data.message??'');
      case ErrorResponse():
        return ErrorResponse(error: result.error);
    }
    
  }
}
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ReadAndWriteTokinUsecase {
  StorageDataSourceContract storageDataSourceContract;
  ReadAndWriteTokinUsecase(this.storageDataSourceContract);

  Future<String?> invokeGetToken() => storageDataSourceContract.getToken();
  Future<BaseResponse<bool>> invokeAddToken(String token) => storageDataSourceContract.addToken(token);
}
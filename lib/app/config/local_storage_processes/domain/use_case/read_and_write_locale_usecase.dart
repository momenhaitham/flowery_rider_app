import 'package:flowery_rider_app/app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReadAndWriteLocaleUsecase {
  final StorageDataSourceContract storageDataSourceContract;
  ReadAndWriteLocaleUsecase(this.storageDataSourceContract);

  Future<String> invokeGetCurrentLocale() => storageDataSourceContract.getCurrentLocale();

  Future<void> invokeSetCurrentLocale(String locale) => storageDataSourceContract.setCurrentLocale(locale);
}
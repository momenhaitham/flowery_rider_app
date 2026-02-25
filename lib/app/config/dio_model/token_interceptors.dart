import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:flowery_rider_app/app/core/consts/app_consts.dart';

class TokenInterceptor extends Interceptor {
  final StorageDataSourceContract secureStorageService;

  TokenInterceptor(this.secureStorageService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await secureStorageService.getToken();
    options.headers['Authorization'] = 'Bearer ${AppConsts.driverToken}';
    return handler.next(options);
  }
}

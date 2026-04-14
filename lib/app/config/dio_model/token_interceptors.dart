import 'package:dio/dio.dart';

import '../local_storage_processes/domain/storage_data_source_contract.dart';


class TokenInterceptor extends Interceptor {
  final StorageDataSourceContract secureStorageService;

  TokenInterceptor(this.secureStorageService);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final result = await secureStorageService.getToken();
    options.headers['Authorization'] = 'Bearer $result';
    return handler.next(options);
  }
}

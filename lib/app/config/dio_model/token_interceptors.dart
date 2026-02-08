import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/storage_data_source_contract.dart';

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

    // if (token != null && token.isNotEmpty) {

    // } else {
    //   var token = TokenManager.token;
    //   options.headers['Authorization'] = 'Bearer $token';
    //   options.headers['token'] = token;
    // }

    return handler.next(options);
  }
}

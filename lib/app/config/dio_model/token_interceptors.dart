import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/read_and_write_tokin_usecase.dart';


class TokenInterceptor extends Interceptor {
  final ReadAndWriteTokinUsecase readAndWriteTokinUsecase;

  TokenInterceptor(this.readAndWriteTokinUsecase);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await readAndWriteTokinUsecase.invokeGetToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    return handler.next(options);
  }
}

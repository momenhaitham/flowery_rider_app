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
    //String? token = await readAndWriteTokinUsecase.invokeGetToken();
    String? token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2OTkxYWY0NGUzNjRlZjYxNDA1NmM5NTAiLCJpYXQiOjE3NzExNTUyNjh9.GOs58yljXDM-0orMX0miYp0QiP-MauxhQk5JgLe9CF4";

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    return handler.next(options);
  }
}

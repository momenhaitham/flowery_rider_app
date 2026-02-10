import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/dio_model/token_interceptors.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/read_and_write_tokin_usecase.dart';
import 'package:flowery_rider_app/app/core/endpoint/app_endpoint.dart';
import 'package:flowery_rider_app/app/feature/apply/api/apply_api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../local_storage_processes/domain/storage_data_source_contract.dart';

@module
abstract class DiModule {
  @lazySingleton
  ApplyApiClient provideApplyApiClient(Dio dio) =>
      ApplyApiClient(dio,baseUrl: AppEndPoint.baseUrl);

  @lazySingleton
  Dio provideDio(
    BaseOptions baseOptions,
    PrettyDioLogger logger,
    TokenInterceptor tokenInterceptor,
    ReadAndWriteTokinUsecase readAndWriteTokinUsecase,
  ) {
    final Dio dio = Dio(BaseOptions(baseUrl: AppEndPoint.baseUrl));
    dio.interceptors.add(tokenInterceptor);
    dio.interceptors.add(logger);

    InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await readAndWriteTokinUsecase.invokeGetToken();
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
    );

    return dio;
  }

  @lazySingleton
  BaseOptions provideBaseOptions() => BaseOptions(
    baseUrl: AppEndPoint.baseUrl,
    sendTimeout: Duration(seconds: 60),
    receiveTimeout: Duration(seconds: 60),
    connectTimeout: Duration(seconds: 60),
  );

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() => PrettyDioLogger(
    requestHeader: kDebugMode,
    requestBody: kDebugMode,
    responseBody: kDebugMode,
    responseHeader: kDebugMode,
  );

  @lazySingleton
  FlutterSecureStorage provideFlutterSecureStorage() => FlutterSecureStorage();

  @lazySingleton
  TokenInterceptor provideTokenInterceptor(
    StorageDataSourceContract storageDataSourceContract,
  ) => TokenInterceptor(storageDataSourceContract);

  @preResolve
  Future<SharedPreferences> provideSharedPreferences() =>
      SharedPreferences.getInstance();
}

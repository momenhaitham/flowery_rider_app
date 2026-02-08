import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_error/server_error_response.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';

Future<BaseResponse<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return SuccessResponse(data: result);
  } on DioException catch (exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        {
          return ErrorResponse(error: ConnectionError());
        }
      default:
        {
          final data = exception.response?.data;

          // The server error response can arrive either as a raw JSON string
          // or as a pre-parsed Map, depending on how Dio is configured and
          // how the backend sends the payload. We handle both defensively
          // to avoid runtime type errors when deserializing.
          Map<String, dynamic>? json;
          if (data is String) {
            final decoded = jsonDecode(data);
            if (decoded is Map<String, dynamic>) {
              json = decoded;
            }
          } else if (data is Map<String, dynamic>) {
            json = data;
          }

          if (json == null) {
            // Fallback when the error body cannot be parsed into the expected shape.
            return ErrorResponse(error: UnexpectedError());
          }
          final response = ServerErrorResponse.fromJson(json);
          return ErrorResponse(error: ServerError(message: response.error ?? response.message));
        }
    }
  } catch (exception) {
    return ErrorResponse(error: UnexpectedError());
  }
}
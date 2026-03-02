import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_error/server_error_response.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:test/test.dart';
void main() {
  group("Testing executeApi", () {
    test("When call executeApi with success response", () async {
      /// act
      var result =
      await executeApi(() async => Future.value(true))
      as SuccessResponse<bool>;

      /// assert
      expect(result.data, equals(true));
    });

    test(
      "When call executeApi throws exception and response should be failure",
          () async {
        /// act
        var result =
        await executeApi(() async => throw Exception()) as ErrorResponse;

        /// assert
        expect(result.error, isA<UnexpectedError>());
      },
    );

    test("When call executeApi throws DioException of type : connectionError"
        "it should return exception of ConnectionError", () async {
      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionError,
        ),
      )
      as ErrorResponse;

      /// assert
      expect(result.error, isA<ConnectionError>());
    });
    test("When call executeApi throws DioException of type : connectionTimeout"
        "it should return exception of ConnectionError", () async {
      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        ),
      )
      as ErrorResponse;

      /// assert
      expect(result.error, isA<ConnectionError>());
    });
    test("When call executeApi throws DioException of type : receiveTimeout"
        "it should return exception of ConnectionError", () async {
      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.receiveTimeout,
        ),
      )
      as ErrorResponse;

      /// assert
      expect(result.error, isA<ConnectionError>());
    });
    test("When call executeApi throws DioException of type : sendTimeout"
        "it should return exception of ConnectionError", () async {
      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.sendTimeout,
        ),
      )
      as ErrorResponse;

      /// assert
      expect(result.error, isA<ConnectionError>());
    });

    test("When call executeApi throws DioException of type : badCertificate"
        "it should return exception of ServerError", () async {
      /// arrange
      final ServerErrorResponse response = ServerErrorResponse(error: "Fail");

      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badCertificate,
          response: Response(
            requestOptions: RequestOptions(),
            data: jsonEncode(response.toJson()),
          ),
        ),
      )
      as ErrorResponse<ServerError>;

      /// assert
      expect((result.error as ServerError).message, equals(response.error));
    });

    test("When call executeApi throws DioException of type : badResponse"
        "it should return exception of ServerError", () async {
      /// arrange
      final ServerErrorResponse response = ServerErrorResponse(error: "Fail");

      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            data: jsonEncode(response.toJson()),
          ),
        ),
      )
      as ErrorResponse<ServerError>;

      /// assert
      expect((result.error as ServerError).message, equals(response.error));
    });
    test("When call executeApi throws DioException of type : cancel"
        "it should return exception of ServerError", () async {
      /// arrange
      final ServerErrorResponse response = ServerErrorResponse(error: "Fail");

      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.cancel,
          response: Response(
            requestOptions: RequestOptions(),
            data: jsonEncode(response.toJson()),
          ),
        ),
      )
      as ErrorResponse<ServerError>;

      /// assert
      expect((result.error as ServerError).message, equals(response.error));
    });
    test("When call executeApi throws DioException of type : unknown"
        "it should return exception of ServerError", () async {
      /// arrange
      final ServerErrorResponse response = ServerErrorResponse(error: "Fail");

      /// act
      var result =
      await executeApi(
            () async => throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.unknown,
          response: Response(
            requestOptions: RequestOptions(),
            data: jsonEncode(response.toJson()),
          ),
        ),
      )
      as ErrorResponse<ServerError>;

      /// assert
      expect((result.error as ServerError).message, equals(response.error));
    });
  });
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_error/server_error_response.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import 'package:flowery_rider_app/app/feature/profile/api/profile_api_client.dart';
import 'package:flowery_rider_app/app/feature/profile/api/profile_remote_data_source_impl.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';


@GenerateMocks([ProfileApiClient])
void main() {
  late ProfileApiClient profileApiClient;
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;

  late DriverAuthResponse driverAuth;
  setUpAll(() {
    profileApiClient = MockProfileApiClient();
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(profileApiClient);
    driverAuth = DriverAuthResponse(
      message: 'success',
      driver: Driver(
        firstName: 's',
        lastName: 's',
        email: 's@yahoo.com',
      )
    );

  });
  group('get profile section', () {
    test(
      'when calling get profile and api return success it should return data',
          () async {
        when(profileApiClient.getProfile()).thenAnswer((_) async => driverAuth);
        var result =
        await profileRemoteDataSourceImpl.getProfile()
        as SuccessResponse<DriverAuthResponse>;
        expect(result, isA<SuccessResponse<DriverAuthResponse>>());
        expect(result.data, equals(driverAuth));
        expect(result.data.driver?.email, equals('s@yahoo.com'));
      },
    );
    test(
      'when calling getProfile and api return error it should return exact error',
          () async {
        final ServerErrorResponse response = ServerErrorResponse(error: "Fail");
        when(profileApiClient.getProfile()).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(),
              data: jsonEncode(response.toJson()),
            ),
          ),
        );
        var result =
        await profileRemoteDataSourceImpl.getProfile()
        as ErrorResponse<DriverAuthResponse>;
        expect(result, isA<ErrorResponse<DriverAuthResponse>>());
        expect(result.error, equals(ServerError(message: response.error)));
      },
    );
  },);
}
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_error/server_error_response.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import 'package:flowery_rider_app/app/feature/profile/api/profile_api_client.dart';
import 'package:flowery_rider_app/app/feature/profile/api/profile_remote_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/profile/data/model/change_password_response.dart';
import 'package:flowery_rider_app/app/feature/profile/data/model/profile_photo_response.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/request/change_password_request.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/request/update_profile_request.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';


@GenerateMocks([ProfileApiClient])
void main() {
  late ProfileApiClient profileApiClient;
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;
  late DriverAuthResponse driverAuth;
  late UpdateProfileRequest updateProfileRequest;
  late ProfilePhotoResponse profilePhotoResponse;
  late File file;
  late ChangePasswordRequest changePasswordRequest;
  late ChangePasswordResponse changePasswordResponse;
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
    updateProfileRequest = UpdateProfileRequest(email: 's@yahoo.com');
    profilePhotoResponse = ProfilePhotoResponse(message: 'success');
    file = File('test/resources/fake_image.png');
    changePasswordRequest = ChangePasswordRequest(
      password: '123',
      newPassword: '123',
    );
    changePasswordResponse = ChangePasswordResponse();
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
  group('updateProfile', () {
    test(
      'when calling update profile and api return success it should return data',
          () async {
        when(
          profileApiClient.updateProfile(updateProfileRequest),
        ).thenAnswer((_) async => driverAuth);
        var result =
        await profileRemoteDataSourceImpl.updateProfile(
          updateProfileRequest,
        )
        as SuccessResponse<DriverAuthResponse>;
        expect(result, isA<SuccessResponse<DriverAuthResponse>>());
        expect(result.data, equals(driverAuth));
        expect(result.data.driver?.email, equals('s@yahoo.com'));
      },
    );
    test(
      'when calling updateProfile and api return error it should return exact error',
          () async {
        final ServerErrorResponse response = ServerErrorResponse(error: "Fail");
        when(profileApiClient.updateProfile(updateProfileRequest)).thenThrow(
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
        await profileRemoteDataSourceImpl.updateProfile(
          updateProfileRequest,
        )
        as ErrorResponse<DriverAuthResponse>;
        expect(result, isA<ErrorResponse<DriverAuthResponse>>());
        expect(result.error, equals(ServerError(message: response.error)));
      },
    );
  });
  group('Profile photo', () {
    test(
      'when calling upload profile photo and api return success it should return data',
          () async {
        when(
          profileApiClient.uploadPhoto(file),
        ).thenAnswer((_) async => profilePhotoResponse);
        var result =
        await profileRemoteDataSourceImpl.uploadPhoto(file)
        as SuccessResponse<ProfilePhotoResponse>;
        expect(result, isA<SuccessResponse<ProfilePhotoResponse>>());
        expect(result.data, equals(profilePhotoResponse));
        expect(result.data.message, equals('success'));
      },
    );
    test(
      'when calling uploadProfilePhoto and api return error it should return exact error',
          () async {
        final ServerErrorResponse response = ServerErrorResponse(error: "Fail");
        when(profileApiClient.uploadPhoto(file)).thenThrow(
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
        await profileRemoteDataSourceImpl.uploadPhoto(file)
        as ErrorResponse<ProfilePhotoResponse>;
        expect(result, isA<ErrorResponse<ProfilePhotoResponse>>());
        expect(result.error, equals(ServerError(message: response.error)));
      },
    );
  });
  group('change password section ', () {
    test(
      'when calling change password and api return success it should return data',
          () async {
        when(
          profileApiClient.changePassword(changePasswordRequest),
        ).thenAnswer((_) async => changePasswordResponse);

        var result =
        await profileRemoteDataSourceImpl.changePassword(
          changePasswordRequest,
        )
        as SuccessResponse<ChangePasswordResponse>;
        expect(result, isA<SuccessResponse<ChangePasswordResponse>>());
        expect(result.data, equals(changePasswordResponse));
        await profileRemoteDataSourceImpl.getProfile()
        as SuccessResponse<DriverAuthResponse>;
        expect(result, isA<SuccessResponse<DriverAuthResponse>>());
        expect(result.data, equals(driverAuth));
      },
    );
    test(
      'when calling reset password and api return error it should return exact error',

          () async {
        final ServerErrorResponse response = ServerErrorResponse(error: "Fail");
        when(profileApiClient.changePassword(changePasswordRequest)).thenThrow(
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
        await profileRemoteDataSourceImpl.changePassword(
          changePasswordRequest,
        )
        as ErrorResponse<ChangePasswordResponse>;
        expect(result, isA<ErrorResponse<ChangePasswordResponse>>());
        await profileRemoteDataSourceImpl.getProfile()
        as ErrorResponse<DriverAuthResponse>;
        expect(result, isA<ErrorResponse<DriverAuthResponse>>());
        expect(result.error, equals(ServerError(message: response.error)));
      },
    );
  });


}
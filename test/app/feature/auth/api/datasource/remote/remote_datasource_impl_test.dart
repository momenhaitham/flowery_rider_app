import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/api/api_auth/api_auth.dart';
import 'package:flowery_rider_app/app/feature/auth/api/datasource/remote/remote_datasource_impl.dart';
import 'package:flowery_rider_app/app/feature/auth/data/model/auth_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_datasource_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late MockAuthApiClient mockApiClient;
  late AuthRemoteDatasourceImpl datasource;

  setUp(() {
    mockApiClient = MockAuthApiClient();
    datasource = AuthRemoteDatasourceImpl(mockApiClient);
  });

  test('returns SuccessResponse when API call succeeds', () async {
    // Arrange
    when(
      mockApiClient.login(any),
    ).thenAnswer((_) async => AuthDto(message: 'Success', token: 'token'));

    // Act
    final result = await datasource.login('email', 'password');

    // Assert
    expect(result, isA<SuccessResponse<AuthDto>>());

    verify(mockApiClient.login(any)).called(1);
  });

  test('returns ErrorResponse when API call throws exception', () async {
    // Arrange
    when(mockApiClient.login(any)).thenThrow(Exception('Network error'));

    // Act
    final result = await datasource.login('email', 'password');

    // Assert
    expect(result, isA<ErrorResponse<AuthDto>>());

    verify(mockApiClient.login(any)).called(1);
  });
}

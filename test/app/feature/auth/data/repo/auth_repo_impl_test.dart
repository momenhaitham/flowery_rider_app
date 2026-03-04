import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/auth/data/datasource/remote/remote_datasource_contract.dart';
import 'package:flowery_rider_app/app/feature/auth/data/model/auth_response.dart';
import 'package:flowery_rider_app/app/feature/auth/data/repo/auth_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/model/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDatasourceContract, StorageDataSourceContract])
void main() {
  provideDummy<BaseResponse<AuthDto>>(
    SuccessResponse<AuthDto>(data: AuthDto(message: 'dummy')),
  );

  late AuthRepoImpl authRepoImpl;
  late MockAuthRemoteDatasourceContract mockRemoteDatasource;
  late MockStorageDataSourceContract mockStorageDataSource;

  setUp(() {
    mockStorageDataSource = MockStorageDataSourceContract();
    mockRemoteDatasource = MockAuthRemoteDatasourceContract();
    authRepoImpl = AuthRepoImpl(mockRemoteDatasource, mockStorageDataSource);
  });

  group('AuthRepoImpl.login', () {
    test(
        'returns SuccessResponse<AuthModel> on success and adds token and remember me to storage', () async {
      provideDummy<BaseResponse<AuthDto>>(SuccessResponse(
          data: AuthDto(message: 'Login Successful', token: 'sample_token')));
      provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
      // Arrange
      when(mockRemoteDatasource.login('email', 'password')).thenAnswer(
        (_) async => SuccessResponse<AuthDto>(
          data: AuthDto(message: 'Login Successful', token: 'sample_token'),
        ),
      );
      when(mockStorageDataSource.addToken('sample_token')).thenAnswer(
            (_) async => SuccessResponse<bool>(data: true),
      );
      when(mockStorageDataSource.addRememberMe(true)).thenAnswer(
            (_) async => SuccessResponse<bool>(data: true),
      );


      // Act
      final result = await authRepoImpl.login(
          'email', 'password', rememberMe: true);

      // Assert
      expect(result, isA<SuccessResponse<AuthModel>>());

      verify(mockRemoteDatasource.login('email', 'password')).called(1);

      verify(mockStorageDataSource.addToken('sample_token')).called(1);
      verify(mockStorageDataSource.addRememberMe(true)).called(1);
      verifyNoMoreInteractions(mockRemoteDatasource);
    });

    test('returns ErrorResponse<AuthModel> on failure', () async {
      // Arrange
      when(mockRemoteDatasource.login('email', 'password')).thenAnswer(
        (_) async => ErrorResponse<AuthDto>(error: Exception('Login Failed')),
      );

      // Act
      final result = await authRepoImpl.login('email', 'password');

      // Assert
      expect(result, isA<ErrorResponse<AuthModel>>());
      verify(mockRemoteDatasource.login('email', 'password')).called(1);
      verifyNoMoreInteractions(mockRemoteDatasource);
    });
  });
}

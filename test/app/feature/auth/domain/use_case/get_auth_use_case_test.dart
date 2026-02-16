import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/model/auth_model.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/repo/auth_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/use_case/get_auth_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_auth_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoContract])
void main() {
  provideDummy<BaseResponse<AuthModel>>(
    SuccessResponse<AuthModel>(data: AuthModel(message: 'dummy')),
  );

  late LoginUserUseCase useCase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepoContract();
    useCase = LoginUserUseCase(mockAuthRepo);
  });

  test('returns SuccessResponse when repo succeeds', () async {
    // Arrange
    when(mockAuthRepo.login('email', 'password')).thenAnswer(
      (_) async => SuccessResponse<AuthModel>(
        data: AuthModel(message: 'Login Successful', token: 'token'),
      ),
    );

    // Act
    final result = await useCase.invoke('email', 'password');

    // Assert
    expect(result, isA<SuccessResponse<AuthModel>>());

    verify(mockAuthRepo.login('email', 'password')).called(1);
    verifyNoMoreInteractions(mockAuthRepo);
  });

  test('returns ErrorResponse when repo fails', () async {
    // Arrange
    when(mockAuthRepo.login('email', 'password')).thenAnswer(
      (_) async => ErrorResponse<AuthModel>(error: Exception('Login Failed')),
    );

    // Act
    final result = await useCase.invoke('email', 'password');

    // Assert
    expect(result, isA<ErrorResponse<AuthModel>>());

    verify(mockAuthRepo.login('email', 'password')).called(1);
    verifyNoMoreInteractions(mockAuthRepo);
  });
}

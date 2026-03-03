import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/token_repo_contract.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/logout_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_user_use_case_test.mocks.dart';


@GenerateMocks([TokenRepoContract])
void main() {
  late TokenRepoContract mockRepo;
  late LogoutUserUseCase useCase;

  setUp(() {
    mockRepo = MockTokenRepoContract();
    useCase = LogoutUserUseCase(mockRepo);
  });

  test('invoke should return value from repo', () async {
    provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
    // arrange
    when(
      mockRepo.clearToken(),
    ).thenAnswer((realInvocation) => Future.value(SuccessResponse(data: true)));

    // act
    final result = await useCase.invoke();

    // assert
    verify(mockRepo.clearToken()).called(1);
    expect(result, isA<SuccessResponse<bool>>());
  });
}

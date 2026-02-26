import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/apply_driver_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/use_case/apply_driver_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_driver_use_case_test.mocks.dart';
@GenerateMocks([ApplyDriverRepoContract])
void main() {
  test('when calling apply driver use case it must call repo', () async{
    ApplyDriverRepoContract repo = MockApplyDriverRepoContract();
    ApplyDriverUseCase useCase = ApplyDriverUseCase(repo);
    ApplyDriverRequest request = ApplyDriverRequest();
    provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
    when(repo.applyDriver(request)).thenAnswer((_) async => SuccessResponse(data: 'success'));
    var result =await useCase.invoke(request);
    expect(result, isA<SuccessResponse<String>>());
    verify(repo.applyDriver(request)).called(1);
  });
}
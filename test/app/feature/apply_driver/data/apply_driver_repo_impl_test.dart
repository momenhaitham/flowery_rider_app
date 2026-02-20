import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/apply_driver_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/apply_driver_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/driver_auth_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_driver_repo_impl_test.mocks.dart';
@GenerateMocks([ApplyDriverDataSourceContract])
void main() {
  test('when calling apply driver it must get data from data source', ()async {
    ApplyDriverDataSourceContract dataSource=MockApplyDriverDataSourceContract();
    ApplyDriverRepoImpl repo=ApplyDriverRepoImpl(dataSource);
    ApplyDriverRequest request=ApplyDriverRequest(
      firstName: 'sayed'
    );
    DriverAuthResponse response=DriverAuthResponse(
      message: 'success',
      driver: Driver(firstName: 'sayed')
    );
    provideDummy<BaseResponse<DriverAuthResponse>>(SuccessResponse(data: response),);
    when(dataSource.applyDriver(request)).thenAnswer((_) async => SuccessResponse(data: response));
    var result=await repo.applyDriver(request);
    expect(result,isA<SuccessResponse<String>>());
    verify(dataSource.applyDriver(request)).called(1);
  });
}
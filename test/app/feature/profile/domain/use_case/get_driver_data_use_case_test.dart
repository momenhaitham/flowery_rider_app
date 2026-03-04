import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/profile_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/get_driver_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_driver_data_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepoContract])
void main() {
  late ProfileRepoContract profileRepo;
  late GetDriverDataUseCase getUserDataUseCase;
  late DriverEntity driverEntity;
  setUpAll(() {
    profileRepo = MockProfileRepoContract();
    getUserDataUseCase = GetDriverDataUseCase(profileRepo);
    driverEntity = DriverEntity(
      firstName: 's',
      lastName: 's',
      email: 's@yahoo.com',
    );
  });

  test(
    'when calling get user data it should get data from repository',
        () async {
      provideDummy<BaseResponse<DriverEntity>>(SuccessResponse(data: driverEntity));
      when(
        profileRepo.getProfile(),
      ).thenAnswer((_) => Future.value(SuccessResponse(data: driverEntity)));
      await getUserDataUseCase.invoke();
      verify(profileRepo.getProfile());
    },
  );
}
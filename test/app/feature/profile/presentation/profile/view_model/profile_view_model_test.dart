import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/get_driver_data_use_case.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_intent.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_state.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'profile_view_model_test.mocks.dart';
@GenerateMocks([GetDriverDataUseCase])
void main() {
  late GetDriverDataUseCase driverUseCase;
  late DriverEntity driverEntity;
  late ProfileViewModel profileViewModel;
  setUpAll(() {
    driverUseCase = MockGetDriverDataUseCase();
    driverEntity = DriverEntity(
      firstName: 's',
      lastName: 's',
      email: 's@yahoo.com',
    );
  });
  setUp(() {
    profileViewModel = ProfileViewModel(driverUseCase);
  });

  blocTest(
    'when calling dointent with get user data  action with success it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<DriverEntity>>(SuccessResponse(data: driverEntity));
      when(driverUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value(SuccessResponse(data: driverEntity));
      });
    },
    build: () => profileViewModel,
    act: (bloc) {
      profileViewModel.doIntent(GetProfileAction());
    },
    expect: () {
      var state = ProfileState(profileState: BaseState());
      return [
        state.copyWith(profileState: BaseState(isLoading: true)),
        state.copyWith(
          profileState: BaseState(isLoading: false, data: driverEntity),
        ),
      ];
    },
  );
  blocTest(
    'when calling dointent with get user data action with error it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<DriverEntity>>(
        ErrorResponse(error: UnexpectedError()),
      );
      when(driverUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value(ErrorResponse(error: UnexpectedError()));
      });
    },
    build: () => profileViewModel,
    act: (bloc) {
      profileViewModel.doIntent(GetProfileAction());
    },
    expect: () {
      var state = ProfileState(profileState: BaseState());
      return [
        state.copyWith(profileState: BaseState(isLoading: true)),
        state.copyWith(profileState: BaseState(error: UnexpectedError())),
      ];
    },
  );

}
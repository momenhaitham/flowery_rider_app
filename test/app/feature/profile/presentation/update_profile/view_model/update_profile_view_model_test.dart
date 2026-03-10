import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/update_profile_use_case.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/upload_profile_photo_use_case.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_intent.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_state.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_view_model.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/get_all_vehicles_use_case.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'update_profile_view_model_test.mocks.dart';

@GenerateMocks([UploadProfilePhotoUseCase, UpdateProfileUseCase,GetAllVehiclesUseCase])
void main() {
  late UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
  late UpdateProfileUseCase updateProfileUseCase;
  late GetAllVehiclesUseCase getAllVehiclesUseCase;
  late UpdateProfileViewModel updateProfileViewModel;
  late ApplyDriverRequest updateProfileRequest;
  late File file;
 late List<VehicleEntity> vehicles;
  setUpAll(() {
    updateProfileUseCase = MockUpdateProfileUseCase();
    uploadProfilePhotoUseCase = MockUploadProfilePhotoUseCase();
    getAllVehiclesUseCase = MockGetAllVehiclesUseCase();
    updateProfileRequest = ApplyDriverRequest(email: 'test@test.com');
    file = File('test/resources/fake_image.png');
    vehicles = [VehicleEntity(vehicleType: "Car")];
  });
  setUp(() {
    updateProfileViewModel = UpdateProfileViewModel(
      updateProfileUseCase,
      uploadProfilePhotoUseCase,
      getAllVehiclesUseCase,
    );
  });
  group('update profile', () {
    blocTest(
      'when calling dointent with update profile action it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
        when(updateProfileUseCase.invoke(updateProfileRequest)).thenAnswer((
            realInvocation,
            ) {
          return Future.value(SuccessResponse(data: 'success'));
        });
      },
      build: () => updateProfileViewModel,
      act: (bloc) {
        updateProfileViewModel.doIntent(
          UpdateProfileAction(updateProfileRequest),
        );
      },
      expect: () {
        var state = UpdateProfileState(
          profileState: BaseState(),
          profilePhotoState: BaseState(),
          vehiclesState: BaseState(),

        );
        return [
          state.copyWith(profileState: BaseState(isLoading: true)),
          state.copyWith(
            profileState: BaseState(isLoading: false,data: 'success'),
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with update profile action with error it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<String>>(
          ErrorResponse(error: UnexpectedError()),
        );
        when(updateProfileUseCase.invoke(updateProfileRequest)).thenAnswer((
            realInvocation,
            ) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
      },
      build: () => updateProfileViewModel,
      act: (bloc) {
        updateProfileViewModel.doIntent(
          UpdateProfileAction(updateProfileRequest),
        );
      },
      expect: () {
        var state = UpdateProfileState(
          profileState: BaseState(),
          profilePhotoState: BaseState(),
          vehiclesState: BaseState(),
        );
        return [
          state.copyWith(profileState: BaseState(isLoading: true)),
          state.copyWith(profileState: BaseState(error: UnexpectedError())),
        ];
      },
    );
  });
  group('upload photo', () {
    blocTest(
      'when calling dointent with upload photo action it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
        when(uploadProfilePhotoUseCase.invoke(file)).thenAnswer((
            realInvocation,
            ) {
          return Future.value(SuccessResponse(data: 'success'));
        });
      },
      build: () => updateProfileViewModel,
      act: (bloc) {
        updateProfileViewModel.doIntent(UploadProfilePhotoAction(file));
      },
      expect: () {
        var state = UpdateProfileState(
          profileState: BaseState(),
          profilePhotoState: BaseState(),
          vehiclesState: BaseState(),
        );
        return [
          state.copyWith(profilePhotoState: BaseState(isLoading: true)),
          state.copyWith(
            profilePhotoState: BaseState(isLoading: false,data: 'success'),
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with upload photo action with error it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<String>>(
          ErrorResponse(error: UnexpectedError()),
        );
        when(uploadProfilePhotoUseCase.invoke(file)).thenAnswer((
            realInvocation,
            ) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
      },
      build: () => updateProfileViewModel,
      act: (bloc) {
        updateProfileViewModel.doIntent(UploadProfilePhotoAction(file));
      },
      expect: () {
        var state = UpdateProfileState(
          profileState: BaseState(),
          profilePhotoState: BaseState(),
          vehiclesState: BaseState(),
        );
        return [
          state.copyWith(profilePhotoState: BaseState(isLoading: true)),
          state.copyWith(
            profilePhotoState: BaseState(error: UnexpectedError()),
          ),
        ];
      },
    );
  });
  blocTest(
    'when calling dointent with get all vehicles action with success it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<List<VehicleEntity>>>(
        SuccessResponse(data: vehicles),
      );
      when(getAllVehiclesUseCase.invoke()).thenAnswer((
          realInvocation,
          ) {
        return Future.value(SuccessResponse(data: vehicles));
      });
    },
    build: () => updateProfileViewModel,
    act: (bloc) {
      updateProfileViewModel.doIntent(UpdateVehicleInitIntent());
    },
    expect: () {
      var state = UpdateProfileState(
        profileState: BaseState(),
        profilePhotoState: BaseState(),
        vehiclesState: BaseState(),
      );
      return [
        state.copyWith(vehiclesState: BaseState(isLoading: true)),
        state.copyWith(
          vehiclesState: BaseState(data: vehicles),
        ),
      ];
    },
  );

  blocTest(
    'when calling dointent with get all vehicles action with error it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<List<VehicleEntity>>>(
        ErrorResponse(error: UnexpectedError()),
      );
      when(getAllVehiclesUseCase.invoke()).thenAnswer((
          realInvocation,
          ) {
        return Future.value(ErrorResponse(error: UnexpectedError()));
      });
    },
    build: () => updateProfileViewModel,
    act: (bloc) {
      updateProfileViewModel.doIntent(UpdateVehicleInitIntent());
    },
    expect: () {
      var state = UpdateProfileState(
        profileState: BaseState(),
        profilePhotoState: BaseState(),
        vehiclesState: BaseState(),
      );
      return [
        state.copyWith(vehiclesState: BaseState(isLoading: true)),
        state.copyWith(
          vehiclesState: BaseState(error: UnexpectedError()),
        ),
      ];
    },
  );

  test(
    'when calling do intent with navigate to profile action it must emit event',
        () async {
      final future = expectLater(
        updateProfileViewModel.streamController.stream,
        emits(isA<NavigateToProfileEvent>()),
      );

      updateProfileViewModel.doIntent(NavigateToProfileAction());

      await future;
    },
  );
}
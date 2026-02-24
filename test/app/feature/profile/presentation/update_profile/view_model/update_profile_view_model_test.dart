import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/request/update_profile_request.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/update_profile_use_case.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/upload_profile_photo_use_case.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_intent.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_state.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'update_profile_view_model_test.mocks.dart';

@GenerateMocks([UploadProfilePhotoUseCase, UpdateProfileUseCase])
void main() {
  late UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
  late UpdateProfileUseCase updateProfileUseCase;
  late UpdateProfileViewModel updateProfileViewModel;
  late UpdateProfileRequest updateProfileRequest;
  late File file;

  setUpAll(() {
    updateProfileUseCase = MockUpdateProfileUseCase();
    uploadProfilePhotoUseCase = MockUploadProfilePhotoUseCase();
    updateProfileRequest = UpdateProfileRequest(email: 'test@test.com');
    file = File('test/resources/fake_image.png');
  });
  setUp(() {
    updateProfileViewModel = UpdateProfileViewModel(
      updateProfileUseCase,
      uploadProfilePhotoUseCase,
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
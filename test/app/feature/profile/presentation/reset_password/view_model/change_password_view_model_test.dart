import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/request/change_password_request.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/use_case/change_password_use_case.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view_model/change_password_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view_model/change_password_intent.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view_model/change_password_state.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view_model/change_password_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_view_model_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  late ChangePasswordUseCase changePasswordUseCase;
  late ChangePasswordViewModel changePasswordViewModel;
  late ChangePasswordRequest changePasswordRequest;
  setUpAll(() {
    changePasswordUseCase = MockChangePasswordUseCase();
    changePasswordRequest = ChangePasswordRequest(
      newPassword: '1234',
      password: '123',
    );
  });
  setUp(() {
    changePasswordViewModel = ChangePasswordViewModel(changePasswordUseCase);
  });

  blocTest(
    'when calling dointent with change password action it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
      when(changePasswordUseCase.invoke(changePasswordRequest)).thenAnswer((
          realInvocation,
          ) {
        return Future.value(SuccessResponse(data: 'success'));
      });
    },
    build: () => changePasswordViewModel,
    act: (bloc) {
      changePasswordViewModel.doIntent(
        ChangePasswordAction(changePasswordRequest),
      );
    },
    expect: () {
      var state = ChangePasswordState(changePasswordState: BaseState());
      return [
        state.copyWith(changePasswordState: BaseState(isLoading: true)),
        state.copyWith(changePasswordState: BaseState(data: 'success')),
      ];
    },
  );
  blocTest(
    'when calling dointent with reset password action with error it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<String>>(
        ErrorResponse(error: UnexpectedError()),
      );
      when(changePasswordUseCase.invoke(changePasswordRequest)).thenAnswer((
          realInvocation,
          ) {
        return Future.value(ErrorResponse(error: UnexpectedError()));
      });
    },
    build: () => changePasswordViewModel,
    act: (bloc) {
      changePasswordViewModel.doIntent(
        ChangePasswordAction(changePasswordRequest),
      );
    },
    expect: () {
      var state = ChangePasswordState(changePasswordState: BaseState());
      return [
        state.copyWith(changePasswordState: BaseState(isLoading: true)),
        state.copyWith(
          changePasswordState: BaseState(error: UnexpectedError()),
        ),
      ];
    },
  );
  test('BackNavigation emits event (broadcast)', () async {
    final future = expectLater(
      changePasswordViewModel.streamController.stream,
      emits(isA<BackToEditProfileNavigationEvent>()),
    );

    changePasswordViewModel.doIntent(BackToEditProfileNavigationAction());

    await future;
  });
}
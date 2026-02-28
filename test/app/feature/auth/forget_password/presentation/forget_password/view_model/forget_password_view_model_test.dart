import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/forget_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/forget_password_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'forget_password_view_model_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase])
void main() {
  late ForgetPasswordUseCase forgetPasswordUseCase;
  late ForgetPasswordViewModel forgetPasswordViewModel;
  late ForgetPasswordRequest forgetPasswordRequest;
  late ForgetPasswordResponse forgetPasswordResponse;
  setUpAll(() {
    forgetPasswordUseCase = MockForgetPasswordUseCase();
    forgetPasswordRequest = ForgetPasswordRequest(email: 'email');
    forgetPasswordResponse = ForgetPasswordResponse();
  });
  setUp(() {
    forgetPasswordViewModel = ForgetPasswordViewModel(forgetPasswordUseCase);
  });

  blocTest(
    'when calling dointent with forget password action it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<ForgetPasswordResponse>>(
        SuccessResponse(data: forgetPasswordResponse),
      );
      when(forgetPasswordUseCase.invoke(forgetPasswordRequest)).thenAnswer((
        realInvocation,
      ) {
        return Future.value(SuccessResponse(data: forgetPasswordResponse));
      });
    },
    build: () => forgetPasswordViewModel,
    act: (bloc) {
      forgetPasswordViewModel.doIntent(
        ForgetPasswordAction(forgetPasswordRequest),
      );
    },
    expect: () {
      var state = ForgetPasswordState(forgetPasswordState: BaseState());
      return [
        state.copyWith(forgetPasswordState: BaseState(isLoading: true)),
        state.copyWith(
          forgetPasswordState: BaseState(data: forgetPasswordResponse),
        ),
      ];
    },
  );
  blocTest(
    'when calling dointent with forget password action with error it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<ForgetPasswordResponse>>(
        ErrorResponse(error: UnexpectedError()),
      );
      when(forgetPasswordUseCase.invoke(forgetPasswordRequest)).thenAnswer((
        realInvocation,
      ) {
        return Future.value(ErrorResponse(error: UnexpectedError()));
      });
    },
    build: () => forgetPasswordViewModel,
    act: (bloc) {
      forgetPasswordViewModel.doIntent(
        ForgetPasswordAction(forgetPasswordRequest),
      );
    },
    expect: () {
      var state = ForgetPasswordState(forgetPasswordState: BaseState());
      return [
        state.copyWith(forgetPasswordState: BaseState(isLoading: true)),
        state.copyWith(
          forgetPasswordState: BaseState(error: UnexpectedError()),
        ),
      ];
    },
  );
  test('BackNavigation emits event (broadcast)', () async {
    final future = expectLater(
      forgetPasswordViewModel.streamController.stream,
      emits(isA<BackToLoginNavigationEvent>()),
    );

    forgetPasswordViewModel.doIntent(BackToLoginNavigation());

    await future;
  });
}
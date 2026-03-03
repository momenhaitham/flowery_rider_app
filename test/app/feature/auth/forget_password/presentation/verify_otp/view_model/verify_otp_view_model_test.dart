import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/verify_otp_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/request/verify_otp_request.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/domain/use_case/verify_otp_use_case.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_event.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_intent.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'verify_otp_view_model_test.mocks.dart';

@GenerateMocks([VerifyOtpUseCase])
void main() {
  late VerifyOtpViewModel verifyOtpViewModel;
  late VerifyOtpUseCase verifyOtpUseCase;
  late VerifyOtpRequest verifyOtpRequest;
  late VerifyOtpResponse verifyOtpResponse;
  setUpAll(() {
    verifyOtpUseCase = MockVerifyOtpUseCase();
    verifyOtpRequest = VerifyOtpRequest(resetCode: 'otp');
    verifyOtpResponse = VerifyOtpResponse();
  });
  setUp(() {
    verifyOtpViewModel = VerifyOtpViewModel(verifyOtpUseCase);
  });
  blocTest(
    'when calling dointent with verify otp action it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<VerifyOtpResponse>>(
        SuccessResponse(data: verifyOtpResponse),
      );
      when(verifyOtpUseCase.invoke(verifyOtpRequest)).thenAnswer((
        realInvocation,
      ) {
        return Future.value(SuccessResponse(data: verifyOtpResponse));
      });
    },
    build: () => verifyOtpViewModel,
    act: (bloc) {
      verifyOtpViewModel.doIntent(VerifyOtpAction(verifyOtpRequest));
    },
    expect: () {
      var state = VerifyOtpState(verifyOtpState: BaseState());
      return [
        state.copyWith(verifyOtpState: BaseState(isLoading: true)),
        state.copyWith(verifyOtpState: BaseState(data: verifyOtpResponse)),
      ];
    },
  );
  blocTest(
    'when calling dointent with verify otp action with error it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<VerifyOtpResponse>>(
        ErrorResponse(error: UnexpectedError()),
      );
      when(verifyOtpUseCase.invoke(verifyOtpRequest)).thenAnswer((
        realInvocation,
      ) {
        return Future.value(ErrorResponse(error: UnexpectedError()));
      });
    },
    build: () => verifyOtpViewModel,
    act: (bloc) {
      verifyOtpViewModel.doIntent(VerifyOtpAction(verifyOtpRequest));
    },
    expect: () {
      var state = VerifyOtpState(verifyOtpState: BaseState());
      return [
        state.copyWith(verifyOtpState: BaseState(isLoading: true)),
        state.copyWith(verifyOtpState: BaseState(error: UnexpectedError())),
      ];
    },
  );
  test('BackNavigation emits event (broadcast)', () async {
    final future = expectLater(
      verifyOtpViewModel.streamController.stream,
      emits(isA<BackNavigationEvent>()),
    );

    verifyOtpViewModel.doIntent(BackNavigation());

    await future;
  });
}
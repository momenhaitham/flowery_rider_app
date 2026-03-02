import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/forget_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/widgets/otp_input_fields.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/widgets/resend_code_text_button.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/widgets/verify_otp_body.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../forget_password/view/forget_password_screen_test.mocks.dart';
import '../verify_otp_screen_test.mocks.dart';

void main() {
  late MockVerifyOtpViewModel mockVerifyOtpViewModel;
  late MockForgetPasswordViewModel mockForgetPasswordViewModel;
  late StreamController<ErrorAnimationType> errorController;
  late String email;
  late GetIt getIt;
  setUp(() {
    mockVerifyOtpViewModel = MockVerifyOtpViewModel();
    mockForgetPasswordViewModel = MockForgetPasswordViewModel();
    errorController = StreamController<ErrorAnimationType>.broadcast();
    email = "ahmed@gmail.com";
    getIt = GetIt.instance;
    if (getIt.isRegistered<VerifyOtpViewModel>()) {
      getIt.unregister<VerifyOtpViewModel>();
    }
    getIt.registerSingleton<VerifyOtpViewModel>(mockVerifyOtpViewModel);
    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
    getIt.registerSingleton<ForgetPasswordViewModel>(mockForgetPasswordViewModel);
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockForgetPasswordViewModel.cubitStream).thenAnswer((_) => const Stream.empty());
    when(mockForgetPasswordViewModel.state).thenReturn(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: false))
    );
  });
  tearDown(() {
    errorController.close();
    if (getIt.isRegistered<VerifyOtpViewModel>()) {
      getIt.unregister<VerifyOtpViewModel>();
    }
    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
  });
  Widget buildTestableWidget({
    required VerifyOtpState state,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: VerifyOtpBody(
          verifyOtpViewModel: mockVerifyOtpViewModel,
          errorController: errorController,
          email: email,
          verifyOtpState: state,
        ),
      ),
    );
  }
  testWidgets('renders all static UI elements correctly', (WidgetTester tester) async {
    final state = VerifyOtpState(verifyOtpState: BaseState(isLoading: false));
    await tester.pumpWidget(buildTestableWidget(state: state));
    expect(find.text(AppLocale.emailVerification.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterOtp.tr()), findsOneWidget);
    expect(find.text(AppLocale.receiveCodeQuestion.tr()), findsOneWidget);
    expect(find.text(AppLocale.resend.tr()), findsOneWidget);
    expect(find.byType(OtpInputFields), findsOneWidget);
    expect(find.byType(ResendCodeTextButton), findsOneWidget);
  });
  testWidgets('shows error message when verifyOtpState has error', (WidgetTester tester) async{
    final state = VerifyOtpState(
      verifyOtpState: BaseState(
        isLoading: false,
        error: Exception('Invalid OTP')
      )
    );
    await tester.pumpWidget(buildTestableWidget(state: state));
    expect(find.text('invalidOtp'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
  },);
  testWidgets('hides error message when verifyOtpState has no error', (WidgetTester tester) async{
    final state = VerifyOtpState(verifyOtpState: BaseState(isLoading: false));
    await tester.pumpWidget(buildTestableWidget(state: state));
    expect(find.text('invalidOtp'), findsNothing);
  },);
  testWidgets('shows snackbar when forget password error occurs', (WidgetTester tester) async{
    final dummyException = Exception('Failed to resend code');
    final state = VerifyOtpState(verifyOtpState: BaseState(isLoading: false));
    final forgetPasswordStateController = StreamController<ForgetPasswordState>.broadcast();
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => forgetPasswordStateController.stream);
    await tester.pumpWidget(buildTestableWidget(state: state));
    forgetPasswordStateController.add(
      ForgetPasswordState(  
        forgetPasswordState: BaseState(
          isLoading: false,
          error: dummyException
        )
      )
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(SnackBar), findsOneWidget);
  },);
  testWidgets('shows snackbar when forget password succeeds', (WidgetTester tester) async{
    final state = VerifyOtpState(verifyOtpState: BaseState(isLoading: false));
    final forgetPasswordStateController = StreamController<ForgetPasswordState>.broadcast();
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => forgetPasswordStateController.stream);
    await tester.pumpWidget(buildTestableWidget(state: state));
    forgetPasswordStateController.add(
      ForgetPasswordState(
        forgetPasswordState: BaseState(
          isLoading: false,
          data: ForgetPasswordResponse(info: 'Code resent successfully')
        )
      )
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Code resent successfully'), findsOneWidget);
    await forgetPasswordStateController.close();
  },);
}
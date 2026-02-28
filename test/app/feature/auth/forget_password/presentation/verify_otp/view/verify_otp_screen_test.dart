import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/verify_otp_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/verify_otp_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/widgets/verify_otp_body.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_event.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_intent.dart' show BackNavigation;
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view_model/verify_otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../forget_password/view/forget_password_screen_test.mocks.dart';
import 'verify_otp_screen_test.mocks.dart';
@GenerateMocks([VerifyOtpViewModel])
void main() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late MockVerifyOtpViewModel mockVerifyOtpViewModel;
  late MockForgetPasswordViewModel mockForgetPasswordViewModel;
  late String email;
  late GetIt getIt;
  setUp(() {
    mockVerifyOtpViewModel=MockVerifyOtpViewModel();
    mockForgetPasswordViewModel=MockForgetPasswordViewModel();
    email="ahmed@gmail.com";
    getIt=GetIt.instance;
    if(getIt.isRegistered<VerifyOtpViewModel>()){
      getIt.unregister<VerifyOtpViewModel>();
    }
    if(getIt.isRegistered<ForgetPasswordViewModel>()){
      getIt.unregister<ForgetPasswordViewModel>();
    }
    getIt.registerSingleton<VerifyOtpViewModel>(mockVerifyOtpViewModel);
    when(mockVerifyOtpViewModel.stream).thenAnswer((_) =>const Stream.empty() ,);
    when(mockVerifyOtpViewModel.cubitStream).thenAnswer((_) =>const Stream.empty() ,);
    when(mockVerifyOtpViewModel.state).thenReturn(VerifyOtpState(verifyOtpState: BaseState(isLoading: false)));
    getIt.registerSingleton<ForgetPasswordViewModel>(mockForgetPasswordViewModel);
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) =>const Stream.empty() ,);
    when(mockForgetPasswordViewModel.cubitStream).thenAnswer((_) =>const Stream.empty() ,);
    when(mockForgetPasswordViewModel.state).thenReturn(ForgetPasswordState(forgetPasswordState: BaseState(isLoading: false)));
  },);
  tearDown(() {
    if(getIt.isRegistered<VerifyOtpViewModel>()){
      getIt.unregister<VerifyOtpViewModel>();
    }
    if(getIt.isRegistered<ForgetPasswordViewModel>()){
      getIt.unregister<ForgetPasswordViewModel>();
    }
  },);
  Widget buildTestableWidget(){
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        if(settings.name==Routes.resetPasswordScreen){
          return MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: Text("Reset password test screen"),),),);
        }
        return MaterialPageRoute(builder: (context) => VerifyOtpScreen(email),);
      },
      initialRoute: '/',
    );
  }
  testWidgets('verify otp screen in initial state', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(VerifyOtpBody), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(Text), findsNWidgets(11));
    expect(find.text(AppLocale.password.tr()),findsOneWidget);
    expect(find.byType(PinCodeTextField), findsOneWidget);
  });
  testWidgets('app bar back button triggers BackNavigation intent', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    final capturedIntent = verify(mockVerifyOtpViewModel.doIntent(captureAny)).captured.single;
    expect(capturedIntent, isA<BackNavigation>());
  },);
  testWidgets('testing loading State', (WidgetTester tester) async{
    final stateController = StreamController<VerifyOtpState>.broadcast();
    when(mockVerifyOtpViewModel.stream).thenAnswer((_) => stateController.stream);
    await tester.pumpWidget(buildTestableWidget());
    stateController.add(
      VerifyOtpState(verifyOtpState: BaseState(isLoading: true))
    );
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(VerifyOtpBody), findsOneWidget);
    await stateController.close();
  },);
  testWidgets('shows error animation and invalidOtp text when error occurs', (WidgetTester tester) async{
    final stateController = StreamController<VerifyOtpState>.broadcast();
    when(mockVerifyOtpViewModel.stream).thenAnswer((_) => stateController.stream);
    await tester.pumpWidget(buildTestableWidget());
    stateController.add(
      VerifyOtpState(
        verifyOtpState: BaseState(
          isLoading: false,
          error: Exception('Invalid OTP')
        )
      )
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text(AppLocale.invalidOtp.tr()), findsOneWidget);
    await stateController.close();
  },);
  testWidgets('navigates to reset password screen on success', (WidgetTester tester) async{
    final stateController = StreamController<VerifyOtpState>.broadcast();
    when(mockVerifyOtpViewModel.stream).thenAnswer((_) => stateController.stream);
    await tester.pumpWidget(buildTestableWidget());
    stateController.add(
      VerifyOtpState(
        verifyOtpState: BaseState(
          isLoading: false,
          data: VerifyOtpResponse()
        )
      )
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Reset password test screen'), findsOneWidget);
    await stateController.close();
  },);
  testWidgets('handles BackNavigationEvent - pops screen', (WidgetTester tester) async{
    final navigationController = StreamController<VerifyOtpEvent>.broadcast();
    when(mockVerifyOtpViewModel.cubitStream).thenAnswer((_) {
      navigationController.stream.listen((event) {
        if (event is BackNavigationEvent) {
          navigatorKey.currentState?.pop();
        }
      });
      return navigationController.stream;
      });
      await tester.pumpWidget(buildTestableWidget());
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => const Scaffold(body: Text('Dummy Screen')),
        ),
      );
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(find.text('Dummy Screen'), findsOneWidget);
      navigationController.add(BackNavigationEvent());
      for (int i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(find.byType(VerifyOtpScreen), findsOneWidget);
      expect(find.text('Dummy Screen'), findsNothing);
      await navigationController.close();
  },);
}
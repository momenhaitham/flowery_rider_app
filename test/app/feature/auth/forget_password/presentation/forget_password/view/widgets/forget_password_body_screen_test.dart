import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/forget_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/widgets/forget_password_body_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../forget_password_screen_test.mocks.dart';

void main() {
  late MockForgetPasswordViewModel mockForgetPasswordViewModel;
  late GetIt getIt;
  setUp(() {
    mockForgetPasswordViewModel=MockForgetPasswordViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
    getIt.registerSingleton<ForgetPasswordViewModel>(mockForgetPasswordViewModel);
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockForgetPasswordViewModel.cubitStream).thenAnswer((_) => const Stream.empty());
    when(mockForgetPasswordViewModel.state).thenReturn(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: false))
    );
  },);
  tearDown(() {
    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
  });
  Widget buildTestableWidget(){
    return MaterialApp(
      home: const ForgetPasswordScreen()
    );
  }
  testWidgets('testing the body screen in initial state', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(ForgetPasswordScreenBody), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(Text), findsNWidgets(6));
    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(AppLocale.forgetPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.forgetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourEmail.tr()), findsOneWidget);
    expect(find.text(AppLocale.email.tr()), findsOneWidget);
    expect(find.text(AppLocale.continueTxt.tr()), findsOneWidget);
  });
  testWidgets('testing the error validation state when pressing the button with empty fields', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(ForgetPasswordScreenBody), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(AppLocale.forgetPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.forgetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourEmail.tr()), findsOneWidget);
    expect(find.text(AppLocale.email.tr()), findsOneWidget);
    expect(find.text("emailRequired".tr()), findsOneWidget);
    expect(find.text(AppLocale.continueTxt.tr()), findsOneWidget);
  },);
  testWidgets('testing the success validation state when entering a valid email', (WidgetTester tester) async{
    final stateController = StreamController<ForgetPasswordState>.broadcast();
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => stateController.stream);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.byType(TextFormField), 'email3@gmail.com');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ForgetPasswordScreenBody), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text(AppLocale.forgetPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.forgetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourEmail.tr()), findsOneWidget);
    expect(find.text('email3@gmail.com'), findsOneWidget);
    expect(find.text(AppLocale.email.tr()), findsOneWidget);
    expect(find.text("emailRequired".tr()), findsNothing);
    expect(find.text(AppLocale.continueTxt.tr()), findsOneWidget);
    expect(find.text(AppLocale.loading.tr()), findsOneWidget);
  },);
}
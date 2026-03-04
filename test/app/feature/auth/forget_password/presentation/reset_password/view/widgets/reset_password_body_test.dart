import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view/reset_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../reset_password_screen_test.mocks.dart';

void main() {
  late MockResetPasswordViewModel mockResetPasswordViewModel;
  late GetIt getIt;
  late String email;
  setUp(() {
    mockResetPasswordViewModel=MockResetPasswordViewModel();
    getIt=GetIt.instance;
    email="ahmed@gmail.com";
    if(getIt.isRegistered<ResetPasswordViewModel>()){
      getIt.unregister<ResetPasswordViewModel>();
    }
    getIt.registerSingleton<ResetPasswordViewModel>(mockResetPasswordViewModel);
    when(mockResetPasswordViewModel.stream).thenAnswer((_) =>const Stream.empty(),);
    when(mockResetPasswordViewModel.cubitStream).thenAnswer((_) =>const Stream.empty(),);
    when(mockResetPasswordViewModel.state).thenReturn(
      ResetPasswordState(resetPasswordState: BaseState(isLoading: false))
    );
  },);
  tearDown(() {
    if(getIt.isRegistered<ResetPasswordViewModel>()){
      getIt.unregister<ResetPasswordViewModel>();
    }
  },);
  Widget buildTestableWidget(){
    return MaterialApp(
      home: ResetPasswordScreen(email),
    );
  }
  testWidgets('testing reset password body in initial state', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
  testWidgets('testing error validation state when pressing the buttons with two empty fields', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(10));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordRequired".tr()), findsOneWidget);
    expect(find.text("confirmPasswordRequired".tr()), findsOneWidget);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  },);
  testWidgets('test error case with short password and empty confirm password', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'So@1');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(10));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordMinLength".tr()), findsOneWidget);
    expect(find.text("confirmPasswordRequired".tr()), findsOneWidget);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  },);
  testWidgets('testing error validation case of using short password in both fields', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'So@1');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'So@1');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordMinLength".tr()), findsOneWidget);
    expect(find.text("confirmPasswordRequired".tr()), findsNothing);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  },);
  testWidgets('testing error validation case of using password with out special character in both fields', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'Solm2020');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'Solm2020');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordSpecialChar".tr()), findsOneWidget);
    expect(find.text("confirmPasswordRequired".tr()), findsNothing);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  },);
  testWidgets('testing error validation case of using password with out using upper case', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'solm@2020');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'solm@2020');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordUpperCase".tr()), findsOneWidget);
    expect(find.text("confirmPasswordRequired".tr()), findsNothing);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  },);
  testWidgets('testing error validation case when using password with out using lower case', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'SOLM@2020');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'SOLM@2020');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordLowerCase".tr()), findsOneWidget);
    expect(find.text("confirmPasswordRequired".tr()), findsNothing);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  },);
  testWidgets('testing error validation case of using two un matched passwords', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'Solm@2020');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'Solm@2021');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordNotMatch".tr()), findsOneWidget);
    expect(find.text("confirmPasswordRequired".tr()), findsNothing);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  },);
  testWidgets('testing success validation case when entering a valid password in the two fields matching', (WidgetTester tester) async{
    final stateController=StreamController<ResetPasswordState>.broadcast();
    when(mockResetPasswordViewModel.stream).thenAnswer((_) =>stateController.stream ,);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'Solm@2020');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'Solm@2020');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ResetPasswordState(resetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text("passwordNotMatch".tr()), findsNothing);
    expect(find.text("confirmPasswordRequired".tr()), findsNothing);
    expect(find.text(AppLocale.resetPasswordQuote.tr()), findsOneWidget);
    expect(find.text(AppLocale.enterYourPassword.tr()), findsOneWidget);
    expect(find.text(AppLocale.loading.tr()), findsOneWidget);
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirm.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await stateController.close();
  },);
}
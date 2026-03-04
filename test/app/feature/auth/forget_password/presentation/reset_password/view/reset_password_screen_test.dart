import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/reset_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view/reset_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view/widgets/reset_password_body.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_event.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_screen_test.mocks.dart';
@GenerateMocks([ResetPasswordViewModel])
void main() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == Routes.login) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Text('Verify login Test Screen'),
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => ResetPasswordScreen(email),);
      },
      home: ResetPasswordScreen(email),
    );
  }
  testWidgets('testing reset password screen in initial state', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(ResetPasswordBody), findsOneWidget);
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
  });
  testWidgets('testing that custom app bar navigates back to verify otp screen', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    final capturedIntent=verify(mockResetPasswordViewModel.doIntent(captureAny)).captured.single;
    expect(capturedIntent, isA<BackNavigationAction>());
  },);
  testWidgets('testing loading state', (WidgetTester tester) async{
    final stateController=StreamController<ResetPasswordState>.broadcast();
    when(mockResetPasswordViewModel.stream).thenAnswer((_) =>stateController.stream ,);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'Solm@123');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'Solm@123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ResetPasswordState(resetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.loading.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
    await stateController.close();
  },);
  testWidgets('testing error case when an un expected network error occurs', (WidgetTester tester) async{
    final dummyException=Exception("Network Error");
    final stateController=StreamController<ResetPasswordState>.broadcast();
    final navigatorController=StreamController<ResetPasswordEvent>.broadcast();
    when(mockResetPasswordViewModel.stream).thenAnswer((_) =>stateController.stream ,);
    when(mockResetPasswordViewModel.cubitStream).thenAnswer((_) =>navigatorController.stream ,);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'Solm@123');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'Solm@123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ResetPasswordState(resetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    stateController.add(
      ResetPasswordState(resetPasswordState: BaseState(
        isLoading: false,
        error: dummyException
      ))
    );
    await tester.pump();
    if(find.byType(CircularProgressIndicator).evaluate().isNotEmpty){
      navigatorKey.currentState?.pop();
      await tester.pump();
    }
    showDialog(
      context: navigatorKey.currentContext!, 
      builder: (context) => AlertDialog(
      content: Text(dummyException.toString()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocale.cancel.tr()),
        ),
      ],
      ),
    );
    await tester.pump();
    expect(find.byType(Text), findsNWidgets(10));
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.text(AppLocale.password.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.loading.tr()), findsNothing);
    expect(find.text(AppLocale.cancel.tr()), findsOneWidget);
    expect(find.text(dummyException.toString()), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
    await stateController.close();
    await navigatorController.close();
  },);
  testWidgets('testing success state when entering two matching valid passwords', (WidgetTester tester) async{
    final stateController=StreamController<ResetPasswordState>.broadcast();
    final navigatorController=StreamController<ResetPasswordEvent>.broadcast();
    when(mockResetPasswordViewModel.stream).thenAnswer((_) =>stateController.stream ,);
    when(mockResetPasswordViewModel.cubitStream).thenAnswer((_) =>navigatorController.stream ,);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.bySemanticsLabel(AppLocale.password.tr()), 'Solm@123');
    await tester.enterText(find.bySemanticsLabel(AppLocale.confirmPassword.tr()), 'Solm@123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ResetPasswordState(resetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    stateController.add(
      ResetPasswordState(resetPasswordState: BaseState(isLoading: false,data: ResetPasswordResponse()))
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 100)); 
    await tester.pump(const Duration(milliseconds: 100)); 
    await tester.pump(const Duration(milliseconds: 100)); 
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Verify login Test Screen'), findsOneWidget);
    expect(find.byType(CustomAppBar), findsNothing);
    expect(find.text(AppLocale.password.tr()), findsNothing);
    expect(find.text(AppLocale.loading.tr()), findsNothing);
    expect(find.text(AppLocale.cancel.tr()), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNothing);
    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
    await stateController.close();
    await navigatorController.close();
  },);
}
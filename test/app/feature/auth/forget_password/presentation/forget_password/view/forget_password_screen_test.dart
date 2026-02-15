import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/data/model/forget_password_response.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/forget_password_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view/widgets/forget_password_body_screen.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'forget_password_screen_test.mocks.dart';
@GenerateMocks([ForgetPasswordViewModel])
void main() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
  Widget buildTestableWidget() {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == Routes.verifyOtpScreen) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text('Verify OTP Test Screen'),
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => const ForgetPasswordScreen(),
      );
      },
      home: const ForgetPasswordScreen(), 
    );
  }
  testWidgets('Initial state of forget password screen ...', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(ForgetPasswordScreenBody), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(Text), findsNWidgets(6));
    expect(find.text(AppLocale.password.tr()), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
  testWidgets('customAppBar handles back navigation to login screen', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byType(IconButton));
    final capturedIntent = verify(mockForgetPasswordViewModel.doIntent(captureAny)).captured.single;
    expect(capturedIntent, isA<BackToLoginNavigation>());
  },);
  testWidgets('testing loading state', (WidgetTester tester) async{
    final stateController = StreamController<ForgetPasswordState>.broadcast();
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => stateController.stream);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.byType(TextFormField), 'email3@gmail.com');
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.text(AppLocale.password.tr()), findsOneWidget);
    expect(find.text(AppLocale.loading.tr()), findsOneWidget);
    expect(find.byType(ForgetPasswordScreenBody), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await stateController.close();
  },);
  testWidgets('testing error case when entering an un registered email', (WidgetTester tester) async{
    final dummyException=Exception("Invalid Email");
    final stateController = StreamController<ForgetPasswordState>.broadcast();
    final navigationController = StreamController<ForgetPasswordEvent>.broadcast();
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => stateController.stream);
    when(mockForgetPasswordViewModel.cubitStream).thenAnswer((_) => navigationController.stream);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.byType(TextFormField), 'email3@gmail.com');
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    stateController.add(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: false,error: dummyException))
    );
    await tester.pump();
    if (find.byType(CircularProgressIndicator).evaluate().isNotEmpty) {
      navigatorKey.currentState?.pop();
      await tester.pump(const Duration(milliseconds: 100));
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
    await tester.pump(const Duration(milliseconds: 100)); 
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.text(AppLocale.password.tr()), findsOneWidget);
    expect(find.byType(ForgetPasswordScreenBody), findsOneWidget);
    expect(find.text(AppLocale.loading.tr()), findsNothing);
    expect(find.text(dummyException.toString()), findsOneWidget);
    expect(find.text(AppLocale.cancel.tr()), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await stateController.close();
    await navigationController.close();
  },);
  testWidgets('testing success case when entering a valid registered email', (WidgetTester tester) async{
    final dummySuccessMessage="Success";
    final stateController = StreamController<ForgetPasswordState>.broadcast();
    final navigationController = StreamController<ForgetPasswordEvent>.broadcast();
    when(mockForgetPasswordViewModel.stream).thenAnswer((_) => stateController.stream);
    when(mockForgetPasswordViewModel.cubitStream).thenAnswer((_) => navigationController.stream);
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.byType(TextFormField), 'email3@gmail.com');
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    stateController.add(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: true))
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    stateController.add(
      ForgetPasswordState(forgetPasswordState: BaseState(isLoading: false,data: ForgetPasswordResponse(info: dummySuccessMessage)))
    );
    await tester.pump();
    if (find.byType(CircularProgressIndicator).evaluate().isNotEmpty) {
      navigatorKey.currentState?.pop();
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.text(AppLocale.password.tr()), findsOneWidget);
    expect(find.byType(ForgetPasswordScreenBody), findsOneWidget);
    expect(find.text(dummySuccessMessage), findsOneWidget);
    expect(find.text(AppLocale.loading.tr()), findsNothing);
    expect(find.text(AppLocale.cancel.tr()), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(SnackBar), findsOneWidget);
    await stateController.close();
    await navigationController.close();
  },);
}
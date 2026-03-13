import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_states.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_view_model.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/controller/remember_controller.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/widget/login_body_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import '../login_screen_widget_test.mocks.dart';

void main() {
  late MockLoginViewModel mockLoginViewModel;
  late GetIt getIt;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late RememberController rememberController;

  setUp(() {
    mockLoginViewModel = MockLoginViewModel();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rememberController = RememberController();

    getIt = GetIt.instance;
    if (getIt.isRegistered<LoginViewModel>()) {
      getIt.unregister<LoginViewModel>();
    }
    getIt.registerSingleton<LoginViewModel>(mockLoginViewModel);

    when(mockLoginViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(
      mockLoginViewModel.state,
    ).thenReturn(LoginStates(loginState: BaseState(isLoading: false)));
  });

  tearDown(() {
    emailController.dispose();
    passwordController.dispose();
    if (getIt.isRegistered<LoginViewModel>()) {
      getIt.unregister<LoginViewModel>();
    }
  });

  Widget buildTestableWidget() {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, child) => EasyLocalization(
        startLocale: const Locale('en'),
        saveLocale: false,
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: Builder(
          builder: (context) => MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: Scaffold(
              body: LoginBodyScreen(
                loginViewModel: mockLoginViewModel,
                emailController: emailController,
                passwordController: passwordController,
                rememberController: rememberController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('testing the body screen in initial state', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    expect(find.byType(LoginBodyScreen), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(find.text('Remember me'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Login'), findsWidgets);
    expect(find.text('Continue as Guest'), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
  });

  testWidgets(
    'testing the error validation state when pressing the button with empty fields',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(LoginBodyScreen), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Login'), findsWidgets);
      expect(find.text('Continue as Guest'), findsOneWidget);
    },
  );

  testWidgets(
    'testing the success validation state when entering a valid email and password',
    (WidgetTester tester) async {
      final stateController = StreamController<LoginStates>.broadcast();
      when(mockLoginViewModel.stream).thenAnswer((_) => stateController.stream);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'email3@gmail.com',
      );
      await tester.pump();
      await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
      await tester.pump();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      stateController.add(LoginStates(loginState: BaseState(isLoading: true)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(LoginBodyScreen), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('email3@gmail.com'), findsOneWidget);
      expect(find.text('Password123!'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Email is required'), findsNothing);
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Login'), findsWidgets);
      expect(find.text('Continue as Guest'), findsOneWidget);

      await stateController.close();
    },
  );
}

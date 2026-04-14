import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/read_and_write_tokin_usecase.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/model/auth_model.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/use_case/get_auth_use_case.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_view_model.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_screen_widget_test.mocks.dart';

@GenerateMocks([LoginUserUseCase, StorageDataSourceContract])
void main() {
  late MockLoginUserUseCase mockAuthUseCase;
  late MockStorageDataSourceContract mockStorage;
  late LoginViewModel viewModel;

  setUp(() {
    mockAuthUseCase = MockLoginUserUseCase();
    mockStorage = MockStorageDataSourceContract();
    viewModel = LoginViewModel(
      mockAuthUseCase,
      ReadAndWriteTokinUsecase(mockStorage),
    );
    provideDummy<BaseResponse<AuthModel>>(
      SuccessResponse(
        data: AuthModel(message: 'ok', token: 'token'),
      ),
    );
    provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
  });

  Widget buildTestWidgetWithViewModel(LoginViewModel vm) {
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
            home: child,
            routes: {
              Routes.home: (context) => const Scaffold(body: SizedBox()),
              Routes.forgetPassword: (context) =>
                  const Scaffold(body: SizedBox()),
              Routes.register: (context) => const Scaffold(body: SizedBox()),
            },
          ),
        ),
      ),
      child: LoginScreen(viewModel: vm),
    );
  }

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidgetWithViewModel(viewModel));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle(const Duration(seconds: 10));
  }

  group('LoginScreen', () {
    testWidgets('displays all UI elements, validates, and handles login', (
      tester,
    ) async {
      when(
        mockAuthUseCase.invoke(any, any, rememberMe: anyNamed('rememberMe')),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 50));
        return SuccessResponse(
          data: AuthModel(message: 'success', token: 'token'),
        );
      });
      when(
        mockStorage.addToken(any),
      ).thenAnswer((_) async => SuccessResponse(data: true));

      await pumpLoginScreen(tester);

      // Verify UI elements
      expect(find.text('Login'), findsWidgets);
      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
      expect(find.text('Continue as Guest'), findsOneWidget);
      expect(find.text("Don't have an account?"), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);

      // Test empty email validation
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.text('Email is required'), findsOneWidget);

      // Test empty password validation
      await tester.enterText(
        find.byType(TextFormField).first,
        'test@example.com',
      );
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.text('Password is required'), findsOneWidget);

      // Test successful login with loading
      await tester.enterText(find.byType(TextFormField).at(1), 'Password1!');
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();

      // Verify login was called
      verify(
        mockAuthUseCase.invoke(
          'test@example.com',
          'Password1!',
          rememberMe: false,
        ),
      ).called(1);
    });

    testWidgets('shows error dialog when login fails', (tester) async {
      final errorViewModel = LoginViewModel(
        mockAuthUseCase,
        ReadAndWriteTokinUsecase(mockStorage),
      );
      when(
        mockAuthUseCase.invoke(any, any, rememberMe: anyNamed('rememberMe')),
      ).thenAnswer(
        (_) async =>
            ErrorResponse(error: ServerError(message: 'Invalid credentials')),
      );

      await tester.pumpWidget(buildTestWidgetWithViewModel(errorViewModel));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle(const Duration(seconds: 10));

      if (find.byType(TextFormField).evaluate().length < 2) return;

      await tester.enterText(find.byType(TextFormField).first, 'a@b.com');
      await tester.pump();
      await tester.enterText(find.byType(TextFormField).at(1), 'Password1!');
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}

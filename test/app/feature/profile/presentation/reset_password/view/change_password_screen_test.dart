import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/back_arrow_icon.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view/change_password_screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view_model/change_password_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view_model/change_password_state.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/reset_password/view_model/change_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'change_password_screen_test.mocks.dart';

@GenerateMocks([ChangePasswordViewModel])
void main() {
  late ChangePasswordViewModel viewModel;
  late GetIt getIt;

  buildWidget() {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      },
      // home:ProfileScreen(),
    );
  }

  setUp(() {
    viewModel = MockChangePasswordViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<ChangePasswordViewModel>()) {
      getIt.unregister<ChangePasswordViewModel>();
    }
    getIt.registerSingleton<ChangePasswordViewModel>(viewModel);
  });
  testWidgets('test change password  init state ', (widgetTester) async {
    when(
      viewModel.state,
    ).thenReturn(ChangePasswordState(changePasswordState: BaseState()));
    when(viewModel.stream).thenAnswer(
      (_) => Stream<ChangePasswordState>.value(
        ChangePasswordState(changePasswordState: BaseState()),
      ),
    );
    when(viewModel.cubitStream).thenAnswer(
      (_) =>
          Stream<ChangePasswordEvent>.value(BackToEditProfileNavigationEvent()),
    );
    await widgetTester.pumpWidget(buildWidget());
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byKey(Key('change_password_padding')), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.text(AppLocale.currentPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.confirmPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.newPassword.tr()), findsNWidgets(2));
    expect(find.text(AppLocale.passwordRequired.tr()), findsNothing);
    expect(find.text(AppLocale.confirmPasswordRequired.tr()), findsNothing);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppLocale.update.tr()), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(BackArrowIcon), findsOneWidget);
  });
  testWidgets('test change password  when tapping with empty fields ', (
    widgetTester,
  ) async {
    when(
      viewModel.state,
    ).thenReturn(ChangePasswordState(changePasswordState: BaseState()));
    when(viewModel.stream).thenAnswer(
      (_) => Stream<ChangePasswordState>.value(
        ChangePasswordState(changePasswordState: BaseState()),
      ),
    );
    when(viewModel.cubitStream).thenAnswer(
      (_) =>
          Stream<ChangePasswordEvent>.value(BackToEditProfileNavigationEvent()),
    );
    await widgetTester.pumpWidget(buildWidget());
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pump();
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byKey(Key('change_password_padding')), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(11));
    expect(find.text(AppLocale.currentPassword), findsNWidgets(2));
    expect(find.text(AppLocale.confirmPassword), findsNWidgets(2));
    expect(find.text(AppLocale.newPassword), findsNWidgets(2));
    expect(find.text(AppLocale.passwordRequired), findsNWidgets(2));
    expect(find.text(AppLocale.confirmPasswordRequired), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppLocale.update), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(BackArrowIcon), findsOneWidget);
  });
  testWidgets(
    'test change password  when tapping with wrong password formate ',
    (widgetTester) async {
      when(
        viewModel.state,
      ).thenReturn(ChangePasswordState(changePasswordState: BaseState()));
      when(viewModel.stream).thenAnswer(
        (_) => Stream<ChangePasswordState>.value(
          ChangePasswordState(changePasswordState: BaseState()),
        ),
      );
      when(viewModel.cubitStream).thenAnswer(
        (_) => Stream<ChangePasswordEvent>.value(
          BackToEditProfileNavigationEvent(),
        ),
      );
      await widgetTester.pumpWidget(buildWidget());
      await widgetTester.enterText(
        find.byKey(Key('current_password_text_field')),
        '123',
      );
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byKey(Key('change_password_padding')), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(1));
      expect(find.byType(Text), findsNWidgets(11));
      expect(find.text(AppLocale.currentPassword), findsNWidgets(2));
      expect(find.text(AppLocale.confirmPassword), findsNWidgets(2));
      expect(find.text(AppLocale.newPassword), findsNWidgets(2));
      expect(find.text(AppLocale.passwordMinLength), findsNWidgets(1));
      expect(find.text(AppLocale.passwordRequired), findsNWidgets(1));
      expect(find.text(AppLocale.confirmPasswordRequired), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(AppLocale.update), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(BackArrowIcon), findsOneWidget);
    },
  );
  testWidgets('test change password  when tapping with not found password', (
    widgetTester,
  ) async {
    when(viewModel.state).thenReturn(
      ChangePasswordState(
        changePasswordState: BaseState(
          error: ServerError(message: 'not found'),
          isLoading: true,
        ),
      ),
    );
    when(viewModel.stream).thenAnswer(
      (_) => Stream<ChangePasswordState>.value(
        ChangePasswordState(
          changePasswordState: BaseState(
            error: ServerError(message: 'not found'),
            isLoading: true,
          ),
        ),
      ),
    );
    when(viewModel.cubitStream).thenAnswer(
      (_) =>
          Stream<ChangePasswordEvent>.value(BackToEditProfileNavigationEvent()),
    );
    await widgetTester.pumpWidget(buildWidget());
    await widgetTester.enterText(
      find.byKey(Key('current_password_text_field')),
      'Sayed@1234',
    );
    await widgetTester.enterText(
      find.byKey(Key('new_password_text_field')),
      'Sayed@123',
    );
    await widgetTester.enterText(
      find.byKey(Key('confirm_password_text_field')),
      'Sayed@123',
    );
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pump();
    expect(find.text('not found'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

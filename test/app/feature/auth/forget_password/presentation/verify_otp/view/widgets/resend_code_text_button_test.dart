import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/widgets/resend_code_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../../forget_password/view/forget_password_screen_test.mocks.dart';

void main() {
  late MockForgetPasswordViewModel mockForgetPasswordViewModel;
  late GetIt getIt;
  setUp(() {
    mockForgetPasswordViewModel = MockForgetPasswordViewModel();
    getIt = GetIt.instance;

    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
    getIt.registerSingleton<ForgetPasswordViewModel>(mockForgetPasswordViewModel);
  });
  tearDown(() {
    if (getIt.isRegistered<ForgetPasswordViewModel>()) {
      getIt.unregister<ForgetPasswordViewModel>();
    }
  });
  Widget buildTestableWidget({
    required VoidCallback onPressed,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ResendCodeTextButton(
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
  testWidgets('renders correct text and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        onPressed: () {
        },
      ),
    );
    expect(find.text(AppLocale.receiveCodeQuestion.tr()), findsOneWidget);
    expect(find.text(AppLocale.resend.tr()), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
  testWidgets('button has correct styling', (WidgetTester tester) async{
    await tester.pumpWidget(
      buildTestableWidget(
        onPressed: () {},
      ),
    );
    final resendText = tester.widget<Text>(find.text('resend'));
    expect(resendText.style?.color, AppColors.primaryColor);
    expect(resendText.style?.decoration, TextDecoration.underline);
    expect(resendText.style?.decorationColor, AppColors.primaryColor);
    final textButton = tester.widget<TextButton>(find.byType(TextButton));
    final resolvedPadding = textButton.style?.padding?.resolve({WidgetState.disabled});
    expect(resolvedPadding, EdgeInsets.zero);
  },);
  testWidgets('layout puts question and button in a row with center alignment', (WidgetTester tester) async{
    await tester.pumpWidget(
      buildTestableWidget(
        onPressed: () {},
      ),
    );
    expect(find.byType(Row), findsOneWidget);
    final row = tester.widget<Row>(find.byType(Row));
    expect(row.children.length, 2);
    expect(row.children[0], isA<Text>());
    expect(row.children[1], isA<TextButton>());
    expect(row.mainAxisAlignment, MainAxisAlignment.center);
  },);
  testWidgets('calls onPressed when resend button is tapped', (WidgetTester tester) async{
     bool onPressedCalled = false;
     await tester.pumpWidget(
        buildTestableWidget(
          onPressed: () {
            onPressedCalled = true;
          },
        ),
      );
      await tester.tap(find.text(AppLocale.resend.tr()));
      await tester.pump();
      expect(onPressedCalled, true);
  },);
  testWidgets('button is tappable multiple times', (WidgetTester tester) async{
    int tapCount = 0;
    await tester.pumpWidget(
      buildTestableWidget(
        onPressed: () {
          tapCount++;
        },
      ),
    );
    await tester.tap(find.text(AppLocale.resend.tr()));
    await tester.pump();
    await tester.tap(find.text(AppLocale.resend.tr()));
    await tester.pump();
    await tester.tap(find.text(AppLocale.resend.tr()));
    await tester.pump();
    expect(tapCount, 3);
  },);
}
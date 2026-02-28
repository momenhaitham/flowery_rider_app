import 'dart:async';

import 'package:flowery_rider_app/app/feature/auth/forget_password/presentation/verify_otp/view/widgets/otp_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  late StreamController<ErrorAnimationType> errorController;
  late bool onCompletedCalled;
  late String completedCode;
  setUp(() {
    errorController = StreamController<ErrorAnimationType>.broadcast();
    onCompletedCalled = false;
    completedCode = '';
  });
  tearDown(() {
    errorController.close();
  });
  Widget buildTestableWidget() {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: OtpInputFields(
            onCompleted: (code) {
              onCompletedCalled = true;
              completedCode = code;
            },
            errorController: errorController,
          ),
        ),
      ),
    );
  }
  testWidgets('renders PinCodeTextField with correct properties', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(PinCodeTextField), findsOneWidget);
    final textField = tester.widget<PinCodeTextField>(find.byType(PinCodeTextField));
    expect(textField.keyboardType, TextInputType.number);
    expect(textField.enableActiveFill, true);
  });
  testWidgets('has correct styling properties', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    final textField = tester.widget<PinCodeTextField>(find.byType(PinCodeTextField));
    expect(textField.animationDuration, const Duration(milliseconds: 300));
    expect(textField.errorAnimationDuration, 400);
    expect(textField.pinTheme, isNotNull);
  },);
  testWidgets('calls onCompleted when 6 digits are entered', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    final textFieldFinder = find.byType(PinCodeTextField);
    expect(textFieldFinder, findsOneWidget);
    await tester.enterText(textFieldFinder, '123456');
    await tester.pump(const Duration(seconds: 1));
    expect(onCompletedCalled, true);
    expect(completedCode, '123456');
    await tester.pump();
  },);
  testWidgets('error controller triggers animation when error added', (WidgetTester tester) async{
    await tester.pumpWidget(buildTestableWidget());
    errorController.add(ErrorAnimationType.shake);
    await tester.pump();
    expect(tester.takeException(), isNull);
  },);
}
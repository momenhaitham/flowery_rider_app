import 'package:flowery_rider_app/app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('onboarding screen testing', (tester) async {
    await tester.pumpWidget(MaterialApp(home: OnboardingScreen()));
    expect(find.byType(ElevatedButton), findsNWidgets(2));
    expect(find.byType(Text), findsNWidgets(5));
    expect(find.byType(Image), findsOneWidget);
  });
}
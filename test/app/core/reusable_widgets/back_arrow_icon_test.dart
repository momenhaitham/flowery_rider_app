import 'package:flowery_rider_app/app/core/reusable_widgets/back_arrow_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders Icon with correct properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
            body: Center(
              child: BackArrowIcon(),
            ),
        ),
      ),
    );
    expect(find.byType(Icon), findsOneWidget);
    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(iconWidget.icon, Icons.arrow_back_ios_rounded);
    expect(iconWidget.color, Colors.black);
  });
}
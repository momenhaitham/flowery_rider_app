import 'package:flowery_rider_app/app/core/reusable_widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows loading dialog with CircularProgressIndicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => AppDialog.viewDialog(context, ''),
            child: const Text('Show'),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('shows message dialog with buttons', (WidgetTester tester) async{
    bool actionCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => AppDialog.viewDialog(
              context, 
              'Test',
              acceptText: 'OK',
              acceptAction: () => actionCalled = true,
              cancelText: 'Cancel',
            ),
            child: const Text('Show'),
          ),
        ),
      ),
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(actionCalled, true);
      expect(find.byType(AlertDialog), findsNothing);
  },);
}
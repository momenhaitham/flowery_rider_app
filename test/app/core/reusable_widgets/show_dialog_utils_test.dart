import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/show_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('showLoading displays loading dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => ShowDialogUtils.showLoading(context),
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
    expect(find.text(AppLocale.loading.tr()), findsOneWidget);
  });
  testWidgets('hideLoading dismisses loading dialog', (WidgetTester tester) async{
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => ShowDialogUtils.showLoading(context),
            child: const Text('Show'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Show'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(AlertDialog), findsOneWidget);  
    navigatorKey.currentState?.pop();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));  
    expect(find.byType(AlertDialog), findsNothing);
  },);
  testWidgets('showMessage displays dialog with buttons', (WidgetTester tester) async{
    bool actionCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => ShowDialogUtils.showMessage(
              context,
              title: 'Title',
              content: 'Content',
              posActionName: AppLocale.ok.tr(),
              posAction: () {
                actionCalled = true;
                Navigator.pop(context);
              },
              nigActionName: AppLocale.cancel.tr(),
            ),
            child: const Text('Show'),
         ),
       ),
     ),
   );
   await tester.tap(find.byType(ElevatedButton));
   await tester.pumpAndSettle();
   expect(find.text(AppLocale.ok.tr()), findsOneWidget);
   expect(find.text(AppLocale.cancel.tr()), findsOneWidget);
   await tester.tap(find.text(AppLocale.ok.tr()));
   await tester.pumpAndSettle();
   expect(actionCalled, true);
   expect(find.byType(AlertDialog), findsNothing);
  },);
}
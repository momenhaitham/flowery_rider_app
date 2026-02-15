import 'package:flowery_rider_app/app/core/reusable_widgets/back_arrow_icon.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/custom_app_bar.dart';
import 'package:flowery_rider_app/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late String testTitle;
  setUp(() {
    testTitle = 'Test Title';
  });
  Widget buildTestableWidget({
    required VoidCallback onLeadingIconClicked,
    required String text,
    ThemeData? theme,
  }) {
    return ScreenUtilInit(
      builder:(context, child) =>  MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          appBar: CustomAppBar(
            onLeadingIconClicked: onLeadingIconClicked,
            text: text,
          ),
          body: const Center(child: Text('Body')),
        ),
      ),
    );
  }
  testWidgets('renders AppBar with correct title text', (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        onLeadingIconClicked: () {
        },
        text: testTitle,
      ),
    );
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text(testTitle), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(BackArrowIcon), findsOneWidget);
  });
  testWidgets('applies correct text style from theme', (WidgetTester tester) async{
    await tester.pumpWidget(
      buildTestableWidget(
        onLeadingIconClicked: () {},
        text: testTitle,
      ),
    );
    final textWidget = tester.widget<Text>(find.text(testTitle));
    final expectedStyle = AppTheme.lightTheme.textTheme.headlineMedium;
    expect(textWidget.style?.color, expectedStyle?.color);
    expect(textWidget.style?.fontFamily, expectedStyle?.fontFamily);
    expect(textWidget.style?.fontWeight, expectedStyle?.fontWeight);
  },);
  testWidgets('handles very long title text', (WidgetTester tester) async{
    const longTitle = 'This is a very long title that might overflow';
    await tester.pumpWidget(
      buildTestableWidget(
        onLeadingIconClicked: () {},
        text: longTitle,
      ),
    );
    expect(find.text(longTitle), findsOneWidget);
    expect(tester.takeException(), isNull);
  },);
  testWidgets('handles empty title text', (WidgetTester tester) async{
    await tester.pumpWidget(
      buildTestableWidget(
        onLeadingIconClicked: () {},
        text: '',
      ),
    );
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  },);
  testWidgets('calls onLeadingIconClicked when back icon is tapped', (WidgetTester tester) async{
    bool iconClicked = false;
    await tester.pumpWidget(
      buildTestableWidget(
        onLeadingIconClicked: () {
          iconClicked = true;
        },
        text: testTitle,
      ),
    );
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(iconClicked, true);
  },);
  testWidgets('implements PreferredSizeWidget with correct preferredSize', (WidgetTester tester) async{
    await tester.pumpWidget(
      buildTestableWidget(
        onLeadingIconClicked: () {},
        text: testTitle,
      ),
    );
    final customAppBar = tester.widget<CustomAppBar>(find.byType(CustomAppBar));
    expect(customAppBar.preferredSize, const Size.fromHeight(kToolbarHeight));
  },);
}
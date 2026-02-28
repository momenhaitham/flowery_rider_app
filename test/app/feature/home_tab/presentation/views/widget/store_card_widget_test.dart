import 'dart:io';

import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/store_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/store_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StoreCardWidget', () {
    final testStore = StoreModel(
      storeName: 'Flower Shop Cairo',
      storeAddress: '45 Tahrir Street, Cairo',
      storePhone: '0223456789',
      storeImage: null,
    );

    Widget buildTestableWidget({required StoreModel store}) {
      return MaterialApp(home: StoreCardWidget(storeModel: store));
    }

    testWidgets('renders all store information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget(store: testStore));
      await tester.pumpAndSettle();
      expect(find.text('Flower Shop Cairo'), findsOneWidget);
      expect(find.text('45 Tahrir Street, Cairo'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    });

    testWidgets('displays store image when provided', (
      WidgetTester tester,
    ) async {
      final storeWithImage = StoreModel(
        storeName: 'Flower Shop with Image',
        storeAddress: '123 Image Street',
        storePhone: '0223456789',
        storeImage: 'https://example.com/store-image.jpg',
      );
      final HttpOverrides? originalHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null; 
      await tester.pumpWidget(buildTestableWidget(store: storeWithImage));
      await tester.pumpAndSettle();
      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(circleAvatar.backgroundImage, isA<NetworkImage>());
      final networkImage = circleAvatar.backgroundImage as NetworkImage;
      expect(networkImage.url, 'https://example.com/store-image.jpg');
      HttpOverrides.global = originalHttpOverrides;
    });

    testWidgets('displays default circle avatar when no image provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget(store: testStore));
      await tester.pumpAndSettle();
      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(circleAvatar.backgroundImage, isNull);
      expect(circleAvatar.backgroundColor, isNull);
    });

    testWidgets('handles empty store name gracefully', (
      WidgetTester tester,
    ) async {
      final storeEmptyName = StoreModel(
        storeName: '',
        storeAddress: '45 Tahrir Street, Cairo',
        storePhone: '0223456789',
        storeImage: null,
      );

      await tester.pumpWidget(buildTestableWidget(store: storeEmptyName));
      await tester.pumpAndSettle();
      expect(find.text(''), findsOneWidget);
      expect(find.text('45 Tahrir Street, Cairo'), findsOneWidget);
    });

    testWidgets('handles null store name gracefully', (
      WidgetTester tester,
    ) async {
      final storeNullName = StoreModel(
        storeName: null,
        storeAddress: '45 Tahrir Street, Cairo',
        storePhone: '0223456789',
        storeImage: null,
      );
      await tester.pumpWidget(buildTestableWidget(store: storeNullName));
      await tester.pumpAndSettle();
      expect(find.text(''), findsOneWidget);
      expect(find.text('45 Tahrir Street, Cairo'), findsOneWidget);
    });

    testWidgets('handles empty store address gracefully', (
      WidgetTester tester,
    ) async {
      final storeEmptyAddress = StoreModel(
        storeName: 'Flower Shop Cairo',
        storeAddress: '',
        storePhone: '0223456789',
        storeImage: null,
      );

      await tester.pumpWidget(buildTestableWidget(store: storeEmptyAddress));
      await tester.pumpAndSettle();
      expect(find.text('Flower Shop Cairo'), findsOneWidget);
      final addressText = tester.widget<Text>(
        find.descendant(of: find.byType(Expanded), matching: find.byType(Text)),
      );
      expect(addressText.data, '');
    });

    testWidgets('handles null store address gracefully', (
      WidgetTester tester,
    ) async {
      final storeNullAddress = StoreModel(
        storeName: 'Flower Shop Cairo',
        storeAddress: null,
        storePhone: '0223456789',
        storeImage: null,
      );
      await tester.pumpWidget(buildTestableWidget(store: storeNullAddress));
      await tester.pumpAndSettle();
      expect(find.text('Flower Shop Cairo'), findsOneWidget);
      final addressText = tester.widget<Text>(
        find.descendant(of: find.byType(Expanded), matching: find.byType(Text)),
      );
      expect(addressText.data, '');
    });

    testWidgets('has correct styling properties', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(store: testStore));
      await tester.pumpAndSettle();
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.color, AppColors.whiteColor);
      expect(card.shape, isA<RoundedRectangleBorder>());

      final roundedRectangle = card.shape as RoundedRectangleBorder;
      expect(roundedRectangle.side.color, AppColors.lightGrayColor);
      expect(roundedRectangle.side.width, 1);
      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.minTileHeight, greaterThan(0));
      expect(listTile.contentPadding, isNotNull);
    });

    testWidgets('displays store phone number when provided', (
      WidgetTester tester,
    ) async {
      final storeWithPhone = StoreModel(
        storeName: 'Flower Shop with Phone',
        storeAddress: '123 Phone Street',
        storePhone: '0223456789',
        storeImage: null,
      );

      await tester.pumpWidget(buildTestableWidget(store: storeWithPhone));
      await tester.pumpAndSettle();
      expect(find.text('Flower Shop with Phone'), findsOneWidget);
      expect(find.text('123 Phone Street'), findsOneWidget);
    });

    testWidgets('handles very long store name', (WidgetTester tester) async {
      final longName =
          'This is an extremely long store name that might cause overflow issues in the UI but should still render without crashing';
      final storeLongName = StoreModel(
        storeName: longName,
        storeAddress: '45 Tahrir Street, Cairo',
        storePhone: '0223456789',
        storeImage: null,
      );
      await tester.pumpWidget(buildTestableWidget(store: storeLongName));
      await tester.pumpAndSettle();
      expect(find.text(longName), findsOneWidget);
      expect(find.byType(StoreCardWidget), findsOneWidget);
    });

    testWidgets('handles very long store address', (WidgetTester tester) async {
      final longAddress =
          'This is an extremely long store address that might cause overflow issues in the UI but should still render without crashing, located at a very specific location with many details';
      final storeLongAddress = StoreModel(
        storeName: 'Flower Shop Cairo',
        storeAddress: longAddress,
        storePhone: '0223456789',
        storeImage: null,
      );
      await tester.pumpWidget(buildTestableWidget(store: storeLongAddress));
      await tester.pumpAndSettle();
      expect(find.text('Flower Shop Cairo'), findsOneWidget);
      final addressFinder = find.text(longAddress);
      expect(addressFinder, findsOneWidget);
    });

    testWidgets('renders correctly with all fields null', (
      WidgetTester tester,
    ) async {
      final emptyStore = StoreModel(
        storeName: null,
        storeAddress: null,
        storePhone: null,
        storeImage: null,
      );

      await tester.pumpWidget(buildTestableWidget(store: emptyStore));
      await tester.pumpAndSettle();
      expect(find.text(''), findsNWidgets(2));
      expect(find.byType(StoreCardWidget), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });
}

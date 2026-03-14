import 'dart:io';

import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/shipping_address_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/user_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserCardWidget', () {
    final testUser = UserModel(
      firstName: 'Ahmed',
      lastName: 'Mohamed',
      phone: '01234567890',
      profileImage: null,
    );
    final testAddress = ShippingAddressModel(
      street: '123 Nile Street',
      city: 'Cairo',
    );

    Widget buildTestableWidget({
      required UserModel user,
      required ShippingAddressModel address,
    }) {
      return MaterialApp(
        home: UserCardWidget(userModel: user, shippingAddressModel: address),
      );
    }

    testWidgets('renders all user information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(user: testUser, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ahmed Mohamed'), findsOneWidget);
      expect(find.text('123 Nile Street'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    });

    testWidgets('displays user profile image when provided', (
      WidgetTester tester,
    ) async {
      final userWithImage = UserModel(
        firstName: 'Ahmed',
        lastName: 'Mohamed',
        phone: '01234567890',
        profileImage: 'https://example.com/user-image.jpg',
      );
      final HttpOverrides? originalHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null;
      await tester.pumpWidget(
        buildTestableWidget(user: userWithImage, address: testAddress),
      );
      await tester.pumpAndSettle();

      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(circleAvatar.backgroundImage, isA<NetworkImage>());
      final networkImage = circleAvatar.backgroundImage as NetworkImage;
      expect(networkImage.url, 'https://example.com/user-image.jpg');
      HttpOverrides.global = originalHttpOverrides;
    });

    testWidgets('displays default circle avatar when no profile image', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(user: testUser, address: testAddress),
      );
      await tester.pumpAndSettle();
      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(circleAvatar.backgroundImage, isNull);
      expect(circleAvatar.backgroundColor, isNull);
    });

    testWidgets('handles empty first name gracefully', (
      WidgetTester tester,
    ) async {
      final userEmptyFirstName = UserModel(
        firstName: '',
        lastName: 'Mohamed',
        phone: '01234567890',
        profileImage: null,
      );

      await tester.pumpWidget(
        buildTestableWidget(user: userEmptyFirstName, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text(' Mohamed'), findsOneWidget);
    });

    testWidgets('handles null first name gracefully', (
      WidgetTester tester,
    ) async {
      final userNullFirstName = UserModel(
        firstName: null,
        lastName: 'Mohamed',
        phone: '01234567890',
        profileImage: null,
      );
      await tester.pumpWidget(
        buildTestableWidget(user: userNullFirstName, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('null Mohamed'), findsOneWidget);
    });

    testWidgets('handles empty last name gracefully', (
      WidgetTester tester,
    ) async {
      final userEmptyLastName = UserModel(
        firstName: 'Ahmed',
        lastName: '',
        phone: '01234567890',
        profileImage: null,
      );

      await tester.pumpWidget(
        buildTestableWidget(user: userEmptyLastName, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ahmed '), findsOneWidget);
    });

    testWidgets('handles null last name gracefully', (
      WidgetTester tester,
    ) async {
      final userNullLastName = UserModel(
        firstName: 'Ahmed',
        lastName: null,
        phone: '01234567890',
        profileImage: null,
      );

      await tester.pumpWidget(
        buildTestableWidget(user: userNullLastName, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ahmed null'), findsOneWidget);
    });

    testWidgets('handles both names null gracefully', (
      WidgetTester tester,
    ) async {
      final userBothNull = UserModel(
        firstName: null,
        lastName: null,
        phone: '01234567890',
        profileImage: null,
      );
      await tester.pumpWidget(
        buildTestableWidget(user: userBothNull, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('null null'), findsOneWidget);
    });

    testWidgets('handles empty street address gracefully', (
      WidgetTester tester,
    ) async {
      final addressEmptyStreet = ShippingAddressModel(
        street: '',
        city: 'Cairo',
      );
      await tester.pumpWidget(
        buildTestableWidget(user: testUser, address: addressEmptyStreet),
      );
      await tester.pumpAndSettle();
      final streetText = tester.widget<Text>(
        find.descendant(of: find.byType(Expanded), matching: find.byType(Text)),
      );
      expect(streetText.data, '');
      expect(find.text('Ahmed Mohamed'), findsOneWidget);
    });

    testWidgets('handles null street address gracefully', (
      WidgetTester tester,
    ) async {
      final addressNullStreet = ShippingAddressModel(
        street: null,
        city: 'Cairo',
      );
      await tester.pumpWidget(
        buildTestableWidget(user: testUser, address: addressNullStreet),
      );
      await tester.pumpAndSettle();
      final streetText = tester.widget<Text>(
        find.descendant(of: find.byType(Expanded), matching: find.byType(Text)),
      );
      expect(streetText.data, '');
      expect(find.text('Ahmed Mohamed'), findsOneWidget);
    });

    testWidgets('has correct styling properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(user: testUser, address: testAddress),
      );
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
      expect(find.text('Ahmed Mohamed'), findsOneWidget);
    });

    testWidgets('handles very long user name', (WidgetTester tester) async {
      final longNameUser = UserModel(
        firstName: 'ThisIsAnExtremelyLongFirstNameThatMightCauseOverflowIssues',
        lastName: 'ThisIsAnExtremelyLongLastNameThatMightCauseOverflowIssues',
        phone: '01234567890',
        profileImage: null,
      );

      await tester.pumpWidget(
        buildTestableWidget(user: longNameUser, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(
        find.text(
          'ThisIsAnExtremelyLongFirstNameThatMightCauseOverflowIssues ThisIsAnExtremelyLongLastNameThatMightCauseOverflowIssues',
        ),
        findsOneWidget,
      );
      expect(find.byType(UserCardWidget), findsOneWidget);
    });

    testWidgets('handles very long street address', (
      WidgetTester tester,
    ) async {
      final longAddress = ShippingAddressModel(
        street:
            'This is an extremely long street address that might cause overflow issues in the UI but should still render without crashing, located at a very specific location with many details',
        city: 'Cairo',
      );

      await tester.pumpWidget(
        buildTestableWidget(user: testUser, address: longAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ahmed Mohamed'), findsOneWidget);
      final addressFinder = find.text(longAddress.street!);
      expect(addressFinder, findsOneWidget);
    });

    testWidgets('renders correctly with all fields null', (
      WidgetTester tester,
    ) async {
      final emptyUser = UserModel(
        firstName: null,
        lastName: null,
        phone: null,
        profileImage: null,
      );

      final emptyAddress = ShippingAddressModel(street: null, city: null);

      await tester.pumpWidget(
        buildTestableWidget(user: emptyUser, address: emptyAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('null null'), findsOneWidget);
      final streetText = tester.widget<Text>(
        find.descendant(of: find.byType(Expanded), matching: find.byType(Text)),
      );
      expect(streetText.data, '');

      expect(find.byType(UserCardWidget), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('displays phone number when provided', (
      WidgetTester tester,
    ) async {
      final userWithPhone = UserModel(
        firstName: 'Ahmed',
        lastName: 'Mohamed',
        phone: '01234567890',
        profileImage: null,
      );

      await tester.pumpWidget(
        buildTestableWidget(user: userWithPhone, address: testAddress),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ahmed Mohamed'), findsOneWidget);
      expect(find.text('123 Nile Street'), findsOneWidget);
    });
  });
}

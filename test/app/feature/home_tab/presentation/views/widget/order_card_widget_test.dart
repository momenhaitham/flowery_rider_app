import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/shipping_address_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/store_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/user_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/order_card_widget.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/store_card_widget.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderCardWidget', () {
    final testOrder = OrderDetailsModel(
      orderId: 'test-order-123',
      orderNumber: 'ORD-2025-001',
      totalPrice: 1500,
      user: UserModel(
        firstName: 'Ahmed',
        lastName: 'Mohamed',
        phone: '01234567890',
        profileImage: null, 
      ),
      shippingAddressModel: ShippingAddressModel(
        street: '123 Nile Street',
        city: 'Cairo',
      ),
      store: StoreModel(
        storeName: 'Flower Shop Cairo',
        storeAddress: '45 Tahrir Street, Cairo',
        storePhone: '0223456789',
        storeImage: null,
      ),
      paymentMethod: 'cash',
      createdAt: DateTime.now().toIso8601String(),
    );

    Widget buildTestableWidget() {
      return MaterialApp(
        home: OrderCardWidget(
          orderDetailsModel: testOrder,
          onAccept: () {},
          onReject: () {},
        ),
      );
    }

    testWidgets('renders all order information correctly', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();
      expect(find.text('flower_order'), findsOneWidget);
      expect(find.text('pick_up_address'), findsOneWidget);
      expect(find.text('userAddress'), findsOneWidget);
      expect(find.text('reject'), findsOneWidget);
      expect(find.text('accept'), findsOneWidget);
      expect(find.text('Flower Shop Cairo'), findsOneWidget);
      expect(find.text('45 Tahrir Street, Cairo'), findsOneWidget);
      expect(find.text('Ahmed Mohamed'), findsOneWidget);
      expect(find.text('123 Nile Street'), findsOneWidget);
      expect(find.text('egp 1500'), findsOneWidget);
      expect(find.byType(StoreCardWidget), findsOneWidget);
      expect(find.byType(UserCardWidget), findsOneWidget);
    });

    testWidgets('handles missing store information gracefully', (
      WidgetTester tester,
    ) async {
      final orderWithoutStore = OrderDetailsModel(
        orderId: 'test-order-456',
        orderNumber: 'ORD-2025-002',
        totalPrice: 750,
        user: UserModel(
          firstName: 'Sara',
          lastName: 'Ahmed',
          phone: '01234567891',
        ),
        shippingAddressModel: ShippingAddressModel(
          street: '456 Nile Street',
          city: 'Alexandria',
        ),
        store: null, 
        paymentMethod: 'cash',
        createdAt: DateTime.now().toIso8601String(),
        orderItems: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderCardWidget(
            orderDetailsModel: orderWithoutStore,
            onAccept: () {},
            onReject: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(StoreCardWidget), findsNothing);
      expect(find.text('storeInfoUnavailable'), findsOneWidget);
      expect(find.byType(UserCardWidget), findsOneWidget);
      expect(find.text('Sara Ahmed'), findsOneWidget);
    });

    testWidgets('handles missing user information gracefully', (
      WidgetTester tester,
    ) async {
      final orderWithoutUser = OrderDetailsModel(
        orderId: 'test-order-789',
        orderNumber: 'ORD-2025-003',
        totalPrice: 1200,
        user: null,
        shippingAddressModel: null,
        store: StoreModel(
          storeName: 'Flower Shop Alexandria',
          storeAddress: '78 Corniche Street, Alexandria',
          storePhone: '0323456789',
        ),
        paymentMethod: 'cash',
        createdAt: DateTime.now().toIso8601String(),
        orderItems: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderCardWidget(
            orderDetailsModel: orderWithoutUser,
            onAccept: () {},
            onReject: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(StoreCardWidget), findsOneWidget);
      expect(find.text('Flower Shop Alexandria'), findsOneWidget);
      expect(find.byType(UserCardWidget), findsNothing);
      expect(find.text('userInfoUnavailable'), findsOneWidget);
    });

    testWidgets('calls onAccept when accept button is tapped', (
      WidgetTester tester,
    ) async {
      bool acceptCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: OrderCardWidget(
            orderDetailsModel: testOrder,
            onAccept: () {
              acceptCalled = true;
            },
            onReject: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('accept'));
      await tester.pump();
      expect(acceptCalled, true);
    });

    testWidgets('calls onReject when reject button is tapped', (
      WidgetTester tester,
    ) async {
      bool rejectCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: OrderCardWidget(
            orderDetailsModel: testOrder,
            onAccept: () {},
            onReject: () {
              rejectCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('reject'));
      await tester.pump();
      expect(rejectCalled, true);
    });

    testWidgets('renders correctly with all fields null', (
      WidgetTester tester,
    ) async {
      final emptyOrder = OrderDetailsModel(
        orderId: null,
        orderNumber: null,
        totalPrice: null,
        user: null,
        shippingAddressModel: null,
        store: null,
        paymentMethod: null,
        createdAt: null,
        orderItems: null,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderCardWidget(
            orderDetailsModel: emptyOrder,
            onAccept: () {},
            onReject: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('storeInfoUnavailable'), findsOneWidget);
      expect(find.text('userInfoUnavailable'), findsOneWidget);
      expect(find.byType(StoreCardWidget), findsNothing);
      expect(find.byType(UserCardWidget), findsNothing);
      expect(find.text('egp null'), findsOneWidget);
    });
  });
}

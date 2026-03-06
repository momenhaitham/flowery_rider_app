// test/app/feature/orders/presentation/view/order_details_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_rider_app/app/feature/orders/domain/model/driver_order_entity.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/view/order_details_screen.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/widgets/order_details_header.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/widgets/order_details_items_card.dart';

DriverOrderEntity buildFakeOrder({String state = 'completed'}) {
  return DriverOrderEntity(
    id: 'order-1',
    driverId: 'driver-1',
    createdAt: DateTime(2025, 1, 1),
    store: const OrderStoreEntity(
      name: 'Flowery Store',
      image: '',
      address: '123 Store St',
      phoneNumber: '01000000000',
      latLong: '0,0',
    ),
    order: OrderEntity(
      id: 'o-1',
      orderNumber: '#TEST-001',
      state: state,
      totalPrice: 500,
      paymentType: 'cash',
      isPaid: false,
      isDelivered: false,
      createdAt: DateTime(2025, 1, 1),
      user: const OrderUserEntity(
        id: 'u-1',
        firstName: 'Ahmed',
        lastName: 'Youssef',
        photo: '',
        phone: '01012345678',
      ),
      orderItems: const [
        OrderItemEntity(productId: 'p-1', price: 250, quantity: 2),
      ],
    ),
  );
}

Widget wrapWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    ensureScreenSize: true,
    builder: (_, __) => MaterialApp(
      home: Scaffold(body: SizedBox(width: 390, height: 844, child: child)),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OrderDetailsScreen —', () {
    testWidgets('renders OrderDetailsHeader widget', (tester) async {
      await tester.pumpWidget(
        wrapWidget(OrderDetailsScreen(driverOrder: buildFakeOrder())),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OrderDetailsHeader), findsOneWidget);
    });

    testWidgets('renders OrderDetailsItemsCard widget', (tester) async {
      await tester.pumpWidget(
        wrapWidget(OrderDetailsScreen(driverOrder: buildFakeOrder())),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OrderDetailsItemsCard), findsOneWidget);
    });
  });

  group('OrderDetailsHeader —', () {
    testWidgets('renders back arrow icon', (tester) async {
      await tester.pumpWidget(
        wrapWidget(OrderDetailsHeader(order: buildFakeOrder().order)),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });

    testWidgets('shows order number', (tester) async {
      await tester.pumpWidget(
        wrapWidget(OrderDetailsHeader(order: buildFakeOrder().order)),
      );
      await tester.pumpAndSettle();

      expect(find.text('#TEST-001'), findsOneWidget);
    });

    testWidgets('shows completed status icon', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          OrderDetailsHeader(order: buildFakeOrder(state: 'completed').order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('shows cancelled status icon', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          OrderDetailsHeader(order: buildFakeOrder(state: 'canceled').order),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.cancel_outlined), findsOneWidget);
    });
  });

  group('OrderDetailsItemsCard —', () {
    testWidgets('shows total price value', (tester) async {
      await tester.pumpWidget(
        wrapWidget(OrderDetailsItemsCard(order: buildFakeOrder().order)),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('500'), findsWidgets);
    });

    testWidgets('shows payment method text', (tester) async {
      await tester.pumpWidget(
        wrapWidget(OrderDetailsItemsCard(order: buildFakeOrder().order)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OrderDetailsItemsCard), findsOneWidget);
    });

    testWidgets('renders one OrderItemRow per item', (tester) async {
      await tester.pumpWidget(
        wrapWidget(OrderDetailsItemsCard(order: buildFakeOrder().order)),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.local_florist_outlined), findsOneWidget);
    });
  });
}

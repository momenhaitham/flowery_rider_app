import 'package:flowery_rider_app/app/feature/track_order/presentation/views/screens/order_delivered_succefully_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('onboarding screen testing', (tester) async {
    await tester.pumpWidget(MaterialApp(home:OrderDeliveredSuccefullyScreen() ));
    expect(find.byType(ElevatedButton), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(4));
    expect(find.byType(SizedBox), findsNWidgets(5));
    expect(find.byType(SvgPicture), findsOneWidget);
  });
}
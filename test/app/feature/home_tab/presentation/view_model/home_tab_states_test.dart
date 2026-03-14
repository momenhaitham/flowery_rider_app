import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_states.dart';
import 'package:test/test.dart';
void main() {
  group('HomeTabStates', () {
    final order1 = OrderDetailsModel(orderId: '1', orderNumber: 'ORD-001');
    
    test('visibleOrders filters rejected orders', () {
      final state = HomeTabStates(
        ordersState: BaseState(data: [order1]),
        rejectedOrderIds: {'1'},
      );
      expect(state.visibleOrders, isEmpty);
    });

    test('currentLoadedCount returns correct count', () {
      final state = HomeTabStates(
        ordersState: BaseState(data: [order1]),
      );
      expect(state.currentLoadedCount, 1);
    });

    test('copyWith creates new instance', () {
      final original = HomeTabStates(hasMoreData: true);
      final copied = original.copyWith(hasMoreData: false);
      expect(copied.hasMoreData, false);
      expect(copied, isNot(equals(original)));
    });
  });
}
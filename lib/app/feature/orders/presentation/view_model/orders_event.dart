import '../../domain/model/driver_order_entity.dart';

sealed class OrdersEvent {}

class NavigateToOrderDetailsEvent extends OrdersEvent {
  final DriverOrderEntity order;
  NavigateToOrderDetailsEvent({required this.order});
}

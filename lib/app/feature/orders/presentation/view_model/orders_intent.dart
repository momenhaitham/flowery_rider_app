import '../../domain/model/driver_order_entity.dart';

sealed class OrdersIntent {}

class LoadOrdersIntent extends OrdersIntent {
  final int page;
  LoadOrdersIntent({this.page = 1});
}

class LoadMoreOrdersIntent extends OrdersIntent {}

class NavigateToOrderDetailsIntent extends OrdersIntent {
  final DriverOrderEntity order;
  NavigateToOrderDetailsIntent({required this.order});
}

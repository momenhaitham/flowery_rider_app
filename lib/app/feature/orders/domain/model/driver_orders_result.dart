import 'driver_order_entity.dart';

class DriverOrdersResult {
  final List<DriverOrderEntity> orders;
  final int totalPages;
  final int currentPage;

  const DriverOrdersResult({
    required this.orders,
    required this.totalPages,
    required this.currentPage,
  });
}

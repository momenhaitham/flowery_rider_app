sealed class HomeTabEvents {}
class GetInitialOrdersEvent extends HomeTabEvents {
  final int? initialLimit;
  GetInitialOrdersEvent({this.initialLimit});
}
class LoadMoreOrdersEvent extends HomeTabEvents {
  final int currentLoadedCount;
  final int? incrementBy;
  LoadMoreOrdersEvent({
    required this.currentLoadedCount,
    this.incrementBy,
  });
}
class RefreshOrdersEvent extends HomeTabEvents {}
class RejectOrderEvent extends HomeTabEvents {
  final String orderId;
  RejectOrderEvent({required this.orderId});
}
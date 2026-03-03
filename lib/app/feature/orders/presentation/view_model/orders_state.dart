import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/model/driver_order_entity.dart';

class OrdersState extends Equatable {
  final BaseState<List<DriverOrderEntity>> ordersState;
  final int currentPage;
  final int totalPages;
  final bool isLoadingMore;

  OrdersState({
    BaseState<List<DriverOrderEntity>>? ordersState,
    this.currentPage = 1,
    this.totalPages = 1,
    this.isLoadingMore = false,
  }) : ordersState = ordersState ?? BaseState();

  bool get isLoading => ordersState.isLoading == true;
  bool get hasError => ordersState.error != null;
  bool get hasData => (ordersState.data?.isNotEmpty) ?? false;
  bool get canLoadMore => currentPage < totalPages && !isLoadingMore;

  int get cancelledCount =>
      ordersState.data?.where((o) => o.order.isCanceled).length ?? 0;

  int get completedCount =>
      ordersState.data?.where((o) => o.order.isCompleted).length ?? 0;

  List<DriverOrderEntity> get orders => ordersState.data ?? [];

  OrdersState copyWith({
    BaseState<List<DriverOrderEntity>>? ordersState,
    int? currentPage,
    int? totalPages,
    bool? isLoadingMore,
  }) => OrdersState(
    ordersState: ordersState ?? this.ordersState,
    currentPage: currentPage ?? this.currentPage,
    totalPages: totalPages ?? this.totalPages,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );

  @override
  List<Object?> get props => [
    ordersState,
    currentPage,
    totalPages,
    isLoadingMore,
  ];
}

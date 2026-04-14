import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../config/base_state/custom_cubit.dart';
import '../../domain/model/driver_orders_result.dart';
import '../../domain/use_case/get_driver_orders_use_case.dart';
import 'orders_event.dart';
import 'orders_intent.dart';
import 'orders_state.dart';

@injectable
class OrdersViewModel extends CustomCubit<OrdersEvent, OrdersState> {
  final GetDriverOrdersUseCase _getDriverOrdersUseCase;

  OrdersViewModel(this._getDriverOrdersUseCase) : super(OrdersState());

  void doIntent(OrdersIntent intent) {
    switch (intent) {
      case LoadOrdersIntent():
        _loadOrders(intent.page);
      case LoadMoreOrdersIntent():
        _loadMoreOrders();
      case NavigateToOrderDetailsIntent():
        streamController.add(NavigateToOrderDetailsEvent(order: intent.order));
    }
  }

  Future<void> _loadOrders(int page) async {
    emit(
      state.copyWith(
        ordersState: BaseState(isLoading: true),
        currentPage: page,
      ),
    );

    final result = await _getDriverOrdersUseCase.call(page: page);

    switch (result) {
      case SuccessResponse<DriverOrdersResult>():
        emit(
          state.copyWith(
            ordersState: BaseState(data: result.data.orders),
            totalPages: result.data.totalPages,
            currentPage: result.data.currentPage,
          ),
        );
      case ErrorResponse<DriverOrdersResult>():
        emit(state.copyWith(ordersState: BaseState(error: result.error)));
    }
  }

  Future<void> _loadMoreOrders() async {
    if (state.isLoadingMore || !state.canLoadMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;
    final result = await _getDriverOrdersUseCase.call(page: nextPage);

    switch (result) {
      case SuccessResponse<DriverOrdersResult>():
        final allOrders = [...state.orders, ...result.data.orders];
        emit(
          state.copyWith(
            ordersState: BaseState(data: allOrders),
            currentPage: result.data.currentPage,
            totalPages: result.data.totalPages,
            isLoadingMore: false,
          ),
        );
      case ErrorResponse<DriverOrdersResult>():
        emit(state.copyWith(isLoadingMore: false));
    }
  }
}

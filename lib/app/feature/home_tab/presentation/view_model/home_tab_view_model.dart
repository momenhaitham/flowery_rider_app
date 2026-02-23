import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/use_cases/home_tab_use_case.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_events.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeTabViewModel extends Cubit<HomeTabStates>{
  final HomeTabUseCase _homeTabUseCase;
  HomeTabViewModel(this._homeTabUseCase):super(HomeTabStates());
  static const int _initialLimit=3;
  static const int _loadMoreIncrement=5;
  void doIntent(HomeTabEvents event){
    switch(event){
      
      case GetInitialOrdersEvent():
        _getInitialOrders(event.initialLimit ?? _initialLimit);
      case LoadMoreOrdersEvent():
        _loadMoreData(event.currentLoadedCount, event.incrementBy ?? _loadMoreIncrement);
      case RefreshOrdersEvent():
        _refreshData();
      case RejectOrderEvent():
        _rejectOrder(event.orderId);
    }
  }
  Future<void> _getInitialOrders(int limit)async{
    emit(state.copyWith(
      ordersState: BaseState<List<OrderDetailsModel>>(
        isLoading: true,
        data: []
      ),
      rejectedOrderIds: {}
    ));
    final res=await _homeTabUseCase.call(limit);
    switch(res){
      
      case SuccessResponse<GetPendingOrdersResponseModel>():
        final orders = res.data.orders;
        final metadata = res.data.metadata;
        final totalItems = metadata?.totalItems ?? orders?.length;
        final hasMoreData = orders!.length < totalItems!;
        emit(state.copyWith(
          ordersState: BaseState<List<OrderDetailsModel>>(
            isLoading: false,
            data: orders
          ),
          metaData: metadata,
          hasMoreData: hasMoreData
        ));
      case ErrorResponse<GetPendingOrdersResponseModel>():
        emit(state.copyWith(
          ordersState: BaseState<List<OrderDetailsModel>>(
            isLoading: false,
            error: res.error
          )
        ));
    }
  }
  Future<void> _loadMoreData(int currentCount,int incrementBy)async{
    if (state.ordersState?.isLoading == true || !state.hasMoreData) return;
    final totalItems = state.metaData?.totalItems ?? 0;
    final remainingItems = totalItems - currentCount;
    int actualIncrement;
    if (remainingItems <= 0) {
      emit(state.copyWith(hasMoreData: false));
      return;
    } else if (remainingItems < incrementBy) {
      actualIncrement = remainingItems;
    } else {
      actualIncrement = incrementBy;
    }
    final newLimit = currentCount + actualIncrement;
    final limit = newLimit > totalItems ? totalItems : newLimit;
    emit(state.copyWith(
      ordersState: BaseState<List<OrderDetailsModel>>(
        isLoading: true,
        data: state.ordersState?.data,
      ),
    ));
    final res=await _homeTabUseCase.call(limit);
    switch(res){
      
      case SuccessResponse<GetPendingOrdersResponseModel>():
        final newOrders = res.data.orders;
        final metadata = res.data.metadata;
        final totalItems = metadata?.totalItems ?? newOrders!.length;
        final hasMoreData = newOrders!.length < totalItems;
        emit(state.copyWith(
          ordersState: BaseState<List<OrderDetailsModel>>(
            isLoading: false,
            data: newOrders
          ),
          metaData: metadata,
          hasMoreData: hasMoreData,
          rejectedOrderIds: state.rejectedOrderIds,
        ));
      case ErrorResponse<GetPendingOrdersResponseModel>():
        emit(state.copyWith(
          ordersState: BaseState<List<OrderDetailsModel>>(
            isLoading: false,
            data: state.ordersState?.data,
            error: res.error
          )
        ));
    }
  }
  Future<void> _refreshData()async{
    await _getInitialOrders(_initialLimit);
  }
  void _rejectOrder(String orderId) {
    final updatedRejectedIds = Set<String>.from(state.rejectedOrderIds)..add(orderId);
    emit(state.copyWith(
      rejectedOrderIds: updatedRejectedIds,
    ));
  }
  bool shouldLoadMore(int lastVisibleIndex) {
    final visibleOrders = state.visibleOrders;
    final isLoading = state.ordersState?.isLoading ?? true;
    return !isLoading && state.hasMoreData && lastVisibleIndex >= visibleOrders.length - 1;
  }
}
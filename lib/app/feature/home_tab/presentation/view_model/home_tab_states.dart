import 'package:equatable/equatable.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/meta_data_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';

class HomeTabStates extends Equatable{
  final BaseState<List<OrderDetailsModel>>? ordersState;
  final MetaDataModel? metaData;
  final bool hasMoreData;
  final Set<String> rejectedOrderIds;
  const HomeTabStates({this.ordersState,this.metaData,this.hasMoreData=false,this.rejectedOrderIds=const {}});
  int get currentLoadedCount => ordersState?.data?.length ?? 0;
  int get totalItems => metaData?.totalItems ?? 0;
  List<OrderDetailsModel> get visibleOrders {
    final allOrders = ordersState?.data ?? [];
    return allOrders.where((order) => !rejectedOrderIds.contains(order.orderId)).toList();
  }
  HomeTabStates copyWith({
    BaseState<List<OrderDetailsModel>>? ordersState,
    MetaDataModel? metaData,
    bool? hasMoreData,
    Set<String>? rejectedOrderIds
  }){
    return HomeTabStates(
      ordersState: ordersState ?? this.ordersState,
      metaData: metaData ?? this.metaData,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      rejectedOrderIds: rejectedOrderIds ?? this.rejectedOrderIds
    );
  }
  
  @override
  List<Object?> get props => [ordersState,metaData,hasMoreData,rejectedOrderIds];
}
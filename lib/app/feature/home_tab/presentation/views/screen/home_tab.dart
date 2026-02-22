import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_events.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_states.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_view_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeTabViewModel viewModel=getIt<HomeTabViewModel>();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  void _onScroll(){
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if(currentScroll>=maxScroll-100){
      final state = viewModel.state;
      final lastIndex = state.visibleOrders.length - 1;
      if(viewModel.shouldLoadMore(lastIndex)){
        viewModel.doIntent(LoadMoreOrdersEvent(currentLoadedCount: state.currentLoadedCount,incrementBy: 5));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.flowery_rider.tr(),style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1),() {
            viewModel.doIntent(RefreshOrdersEvent());
          },);
        },
        child: BlocProvider<HomeTabViewModel>(
          create: (context) => viewModel..doIntent(GetInitialOrdersEvent(initialLimit: 5)),
          child: BlocBuilder<HomeTabViewModel,HomeTabStates>(
            builder: (context, state) {
              final ordersState = state.ordersState;
              if(ordersState?.isLoading==true && ordersState!.data!.isEmpty){
                return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
              }else if(ordersState?.isLoading==false && ordersState?.error!=null && ordersState?.data==null){
                return Center(child: Text(getException(context, ordersState!.error!),style: Theme.of(context).textTheme.bodyMedium,),);
              }else if(ordersState?.isLoading==false && ordersState!.data!.isEmpty){
                return Center(child: Text(AppLocale.noPendingOrders.tr(),style: Theme.of(context).textTheme.bodyMedium,),);
              }else{
                final visibleOrders = state.visibleOrders;
                return ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 0.04*width),
                  itemBuilder: (context, index) {
                    return OrderCardWidget(
                      orderDetailsModel: visibleOrders[index],
                      onAccept: () {
                        
                      },
                      onReject: () {
                        viewModel.doIntent(RejectOrderEvent(orderId: visibleOrders[index].orderId!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.errorColor,
                            content: Text(AppLocale.orderRejected,style: Theme.of(context).textTheme.titleMedium,),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    );
                  }, 
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 0.02*height,
                    );
                  }, 
                  itemCount: visibleOrders.length+(state.hasMoreData? 1 : 0)
                );
              }
            },
          ),
        ),
      )
    );
  }
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
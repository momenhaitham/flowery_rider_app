import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/config/di/di.dart';
import '../../../../core/app_locale/app_locale.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/routes/app_route.dart';
import '../view_model/orders_event.dart';
import '../view_model/orders_intent.dart';
import '../view_model/orders_state.dart';
import '../view_model/orders_view_model.dart';
import '../widgets/order_list_card.dart';
import '../widgets/orders_summary_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final OrdersViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<OrdersViewModel>();
    _viewModel.doIntent(LoadOrdersIntent(page: 1));
    _scrollController.addListener(_onScroll);
    _viewModel.streamController.stream.listen(_handleEvent);
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      _viewModel.doIntent(LoadMoreOrdersIntent());
    }
  }

  void _handleEvent(OrdersEvent event) {
    if (!mounted) return;
    if (event is NavigateToOrderDetailsEvent) {
      Navigator.pushNamed(context, Routes.orderDetails, arguments: event.order);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseWhiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<OrdersViewModel, OrdersState>(
                bloc: _viewModel,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  if (state.hasError) return _buildError();
                  if (!state.hasData) return _buildEmpty();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryDashboard(state),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                        child: Text(
                          AppLocale.recentOrders.tr(),
                          style: TextStyle(
                            fontFamily: FontsFamily.inter,
                            fontSize: FontSize.s18.sp,
                            fontWeight: FontWeights.medium,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                          itemCount:
                              state.orders.length +
                              (state.isLoadingMore ? 1 : 0),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            if (index == state.orders.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              );
                            }
                            return OrderListCard(
                              driverOrder: state.orders[index],
                              onTap: () => _viewModel.doIntent(
                                NavigateToOrderDetailsIntent(
                                  order: state.orders[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w, bottom: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.r,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            AppLocale.myOrders.tr(),
            style: TextStyle(
              fontFamily: FontsFamily.inter,
              fontSize: FontSize.s20.sp,
              fontWeight: FontWeights.medium,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryDashboard(OrdersState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Row(
        children: [
          Expanded(
            child: OrdersSummaryCard(
              count: state.cancelledCount,
              label: AppLocale.cancelled.tr(),
              icon: Icons.cancel_outlined,
              iconColor: AppColors.errorColor,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: OrdersSummaryCard(
              count: state.completedCount,
              label: AppLocale.completed.tr(),
              icon: Icons.check_circle_outline,
              iconColor: AppColors.successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.r, color: AppColors.errorColor),
          SizedBox(height: 16.h),
          Text(
            'Something went wrong. Please try again.',
            style: TextStyle(
              fontFamily: FontsFamily.inter,
              fontSize: FontSize.s14.sp,
              color: AppColors.grayColor,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => _viewModel.doIntent(LoadOrdersIntent(page: 1)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  color: AppColors.baseWhiteColor,
                  fontFamily: FontsFamily.inter,
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeights.medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64.r,
            color: AppColors.primaryColor.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocale.noOrdersYet.tr(),
            style: TextStyle(
              fontFamily: FontsFamily.inter,
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeights.medium,
              color: AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }
}

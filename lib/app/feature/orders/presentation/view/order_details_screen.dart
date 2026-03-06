import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_locale/app_locale.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/font_manager.dart';
import '../../domain/model/driver_order_entity.dart';
import '../widgets/address_info_card.dart';
import '../widgets/order_details_header.dart';
import '../widgets/order_details_items_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  final DriverOrderEntity driverOrder;

  const OrderDetailsScreen({super.key, required this.driverOrder});

  @override
  Widget build(BuildContext context) {
    final order = driverOrder.order;
    final store = driverOrder.store;

    return Scaffold(
      backgroundColor: AppColors.baseWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            OrderDetailsHeader(order: order),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    _buildSectionLabel(AppLocale.pickupAddress.tr()),
                    SizedBox(height: 8.h),
                    AddressInfoCard(
                      name: store.name,
                      address: store.address,
                      isStore: true,
                    ),
                    SizedBox(height: 24.h),

                    _buildSectionLabel(AppLocale.userAddress.tr()),
                    SizedBox(height: 8.h),
                    AddressInfoCard(
                      name: order.user.fullName,
                      address: order.user.phone,
                      isStore: false,
                      photoUrl: order.user.photo,
                    ),
                    SizedBox(height: 24.h),

                    _buildSectionLabel(AppLocale.orderDetails.tr()),
                    SizedBox(height: 8.h),
                    OrderDetailsItemsCard(order: order),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: FontsFamily.inter,
        fontSize: FontSize.s14.sp,
        fontWeight: FontWeights.medium,
        color: AppColors.blackColor,
      ),
    );
  }
}

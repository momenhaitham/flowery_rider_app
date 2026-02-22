import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/store_card_widget.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/widget/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  const OrderCardWidget({super.key,required this.orderDetailsModel,required this.onAccept,required this.onReject});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.04*width,
        vertical: 0.01*height
      ),
      height: 0.25*height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.03*width),
        border: Border.all(width: 1,color: AppColors.lightGrayColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocale.flower_order.tr(),style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: FontSize.s14
          ),),
          SizedBox(height: 0.01*height,),
          Text(AppLocale.pick_up_address.tr(),style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: FontSize.s12
          ),),
          SizedBox(height: 0.007*height,),
          StoreCardWidget(storeModel: orderDetailsModel.store!),
          SizedBox(height: 0.01*height,),
          Text(AppLocale.userAddress.tr(),style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: FontSize.s12
          ),),
          SizedBox(height: 0.007*height,),
          UserCardWidget(
            userModel: orderDetailsModel.user!, 
            shippingAddressModel: orderDetailsModel.shippingAddressModel!
          ),
          SizedBox(height: 0.01*height,),
          Row(
            children: [
              Text('${AppLocale.egp.tr()} ${orderDetailsModel.totalPrice}',style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: FontSize.s14,
                fontWeight: FontWeights.semiBold
              ),),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: WidgetStateProperty.all(AppColors.whiteColor),
                  foregroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    side: BorderSide(width: 1,color: AppColors.primaryColor)
                  ),),
                ),
                onPressed: onReject, 
                child: Text(AppLocale.reject.tr())
              ),
              ElevatedButton(
                onPressed: onAccept, 
                child: Text(AppLocale.accept.tr())
              )
            ],
          )
        ],
      ),
    );
  }
}
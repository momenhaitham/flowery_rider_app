import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderItemCard extends StatelessWidget{
  String? orderItemTitle;
  String? orderItemPrice;
  String? orderItemQuantity;
  String? orderItemImage;

  OrderItemCard({super.key, this.orderItemTitle,this.orderItemPrice,this.orderItemQuantity,this.orderItemImage});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height*AppSize.s0_10,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12),color: AppColors.baseWhiteColor,
      boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(AppSize.s0_08), 
          blurRadius: AppSize.s10, 
          spreadRadius: 1, 
          offset: Offset(0, 4),
        ),
      ]
      ),
      child: Row(
        children: [
          SizedBox(width: width*AppSize.s0_02,),
          SizedBox(
            height: height*AppSize.s0_07,
            width: width*AppSize.s0_15,
            child: ClipRRect(borderRadius: BorderRadius.circular(100),
            child:orderItemImage != null && orderItemImage != "" ?Image.network(orderItemImage!,fit: BoxFit.fill,):Image.asset(AssetsImage.user,fit: BoxFit.fill,),
            ),
          ),
          SizedBox(width: width*AppSize.s0_03,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderItemTitle??"",style:  Theme.of(context).textTheme.labelMedium,),
              SizedBox(height: height*AppSize.s0_01,),
              Row(
                children: [
                  Text("EGP",style:  Theme.of(context).textTheme.labelLarge,),
                  SizedBox(height: AppSize.s0_01,),
                  Text(orderItemPrice??"",style:  Theme.of(context).textTheme.labelLarge,)
                ],
              )
            ],
          ),
          SizedBox(width: AppSize.s0_01,),
          Spacer(),
          Text("X${orderItemQuantity??""}",style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primaryColor),),
          SizedBox(width: AppSize.s0_03,),
        ],
      ),
      
    );
  }

}
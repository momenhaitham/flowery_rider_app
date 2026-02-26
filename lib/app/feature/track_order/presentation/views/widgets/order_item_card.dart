import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
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
      height: height*0.10,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppColors.baseWhiteColor,
      boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(0.08), 
          blurRadius: 10, 
          spreadRadius: 1, 
          offset: Offset(0, 4),
        ),
      ]
      ),
      child: Row(
        children: [
          SizedBox(width: width*0.01,),
          SizedBox(
            height: height*0.07,
            width: width*0.16,
            child: ClipRRect(borderRadius: BorderRadius.circular(100),
            child:orderItemImage != null && orderItemImage != "" ?Image.network(orderItemImage!,fit: BoxFit.fill,):Image.asset(AssetsImage.user,fit: BoxFit.fill,),
            ),
          ),
          SizedBox(width: width*0.03,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderItemTitle??"",style:  Theme.of(context).textTheme.labelMedium,),
              SizedBox(height: height*0.01,),
              Row(
                children: [
                  Text("EGP",style:  Theme.of(context).textTheme.labelLarge,),
                  SizedBox(height: height*0.01,),
                  Text(orderItemPrice??"",style:  Theme.of(context).textTheme.labelLarge,)
                ],
              )
            ],
          ),
          SizedBox(width: width*0.01,),
          Spacer(),
          Text("X${orderItemQuantity??""}",style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primaryColor),),
          SizedBox(width: width*0.03,),
        ],
      ),
      
    );
  }

}
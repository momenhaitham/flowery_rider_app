import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TotalAndPaymentMethodCard extends StatelessWidget{
  String? title;
  String? value;

  TotalAndPaymentMethodCard({super.key,this.title,this.value});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height*0.07,
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
          SizedBox(width: width*0.02,),
          Text(title??"",style:  Theme.of(context).textTheme.headlineLarge,),
          Spacer(),
          Text(value??"",style:  Theme.of(context).textTheme.headlineLarge,),
          SizedBox(width: width*0.03,),
        ],
      ),
      
    );
  }

}
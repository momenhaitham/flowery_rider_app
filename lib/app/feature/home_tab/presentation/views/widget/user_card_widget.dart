import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/shipping_address_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/user_model.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  final UserModel userModel;
  final ShippingAddressModel shippingAddressModel;
  const UserCardWidget({super.key,required this.userModel,required this.shippingAddressModel});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.03*width),
        side: BorderSide(width: 1,color: AppColors.lightGrayColor)
      ),
      child: ListTile(
        minTileHeight: 0.05*height,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0.02*width,
          vertical: 0.01*height
        ),
        leading: CircleAvatar(
          radius: 0.04*width,
          backgroundImage:userModel.profileImage!=null? NetworkImage(userModel.profileImage!):null,
        ),
        title: Text('${userModel.firstName} ${userModel.lastName}',style: Theme.of(context).textTheme.labelMedium,),
        subtitle: Row(
          children: [
            Icon(Icons.location_on_outlined,color: AppColors.blackColor,),
            SizedBox(width: 0.01*width,),
            Expanded(
              child: Text(shippingAddressModel.street ?? '',style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: FontSize.s13,
                fontWeight: FontWeights.regular
              ),),
            )
          ],
        ),
      ),
    );
  }
}
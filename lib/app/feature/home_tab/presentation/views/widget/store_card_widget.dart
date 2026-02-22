import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/store_model.dart';
import 'package:flutter/material.dart';

class StoreCardWidget extends StatelessWidget {
  final StoreModel storeModel;
  const StoreCardWidget({super.key,required this.storeModel});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.03*width),
        side: BorderSide(width: 1,color: AppColors.lightGrayColor)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0.02*width,
          vertical: 0.01*height
        ),
        leading: CircleAvatar(
          radius: 0.44*width,
          backgroundImage: NetworkImage(storeModel.storeImage!),
        ),
        title: Text(storeModel.storeName!,style: Theme.of(context).textTheme.labelMedium,),
        subtitle: Row(
          children: [
            Icon(Icons.location_on_outlined,color: AppColors.blackColor,),
            SizedBox(width: 0.01*width,),
            Text(storeModel.storeAddress!,style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: FontSize.s13,
              fontWeight: FontWeights.regular
            ),)
          ],
        ),
      ),
    );
  }
}
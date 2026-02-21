import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/widget/profile_photo_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/app_colors.dart';

class ProfileCartWidget extends StatelessWidget {
  const ProfileCartWidget({super.key,this.photoUrl,
    required this.title,required this.subtitle,required this.subSubTitle});
final String? photoUrl;
final String title;
final String subtitle;
final String subSubTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grayColor, width: .25)
        ),
       child: ListTile(
         leading:photoUrl!=null? ProfilePhotoWidget(photoUrl:photoUrl??'' ):null,
         title:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(
               color: AppColors.blackColor,
             )),
             const SizedBox(width: 10),
             Text(subtitle,style: Theme.of(context).textTheme.titleSmall),
             const SizedBox(width: 10),
             Text(subSubTitle,style: Theme.of(context).textTheme.titleSmall),
           ],
         ),
        trailing: Icon(Icons.arrow_forward_ios),
       ),
      ),
    );
  }
}

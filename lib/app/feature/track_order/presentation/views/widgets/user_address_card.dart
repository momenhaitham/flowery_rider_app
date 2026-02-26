import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class UserAddressCard extends StatelessWidget{
  String? userImage;
  String? userName;
  String? userAddress;
  String? usePhoneNumber;
  UserAddressCard ({super.key,this.userImage,this.userName,this.userAddress,this.usePhoneNumber});
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
          Container(
            height: height*0.07,
            width: width*0.16,
            child: ClipRRect(borderRadius: BorderRadius.circular(100),
            child: userImage != null && userImage != "" ? Image.network(userImage!,fit: BoxFit.fill,):Image.asset(AssetsImage.user,fit: BoxFit.fill,),
            ),
          ),
          SizedBox(width: width*0.01,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName??"",style:  Theme.of(context).textTheme.labelMedium,),
              SizedBox(height: height*0.01,),
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(height: height*0.01,),
                  Text(userAddress??"",style:  Theme.of(context).textTheme.labelLarge,)
                ],
              )
            ],
          ),
          SizedBox(width: width*0.01,),
          Spacer(),
          InkWell(child: Icon(Icons.call,color: AppColors.primaryColor,),onTap: ()async{
           final uri = Uri.parse("tel:$usePhoneNumber");
           await launchUrl(uri, mode: LaunchMode.externalApplication);
          },),
          SizedBox(width: width*0.03,),
          InkWell(child: Icon(FontAwesomeIcons.whatsapp,color: AppColors.primaryColor,),onTap: ()async{
            final phone = usePhoneNumber?.substring(1);
            final uri = Uri.parse("whatsapp://send?phone=$phone");
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              final fallback = Uri.parse(
                "https://wa.me/$usePhoneNumber",
              );
              await launchUrl(fallback, mode: LaunchMode.externalApplication);
            }
          }),
          SizedBox(width: width*0.02,),
        ],
      ),
      
    );
  }

}
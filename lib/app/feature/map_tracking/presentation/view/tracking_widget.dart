import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../map_tracking_argument.dart';
import '../view_model/tracking_intent.dart';

import 'address_section.dart';

class TrackingWidget extends StatelessWidget {
  const TrackingWidget({super.key,required this.trackingModel,
    this.choosableEnum=ChoosableEnum.isStore,required this.viewModel
  });
 final TrackingModel trackingModel;
 final ChoosableEnum choosableEnum;
 final TrackingViewModel viewModel;


  @override
  Widget build(BuildContext context) {
   return Stack(
      key: const Key('map_tracking_stack'),
      children: [
        // 1. Map Background (Placeholder)
        Container(//1
          width: double.infinity,
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Center(
            key: const Key('map_tracking_success_center'),
            child:_buildMap(
              driverLat:trackingModel.driverLat??0,
              driverLng:trackingModel.driverLong??0,
              addressLat:choosableEnum==ChoosableEnum.isUser? double.parse(trackingModel.clientLat??'0'):double.parse(trackingModel.storeLat??'0'),
              addressLng:choosableEnum==ChoosableEnum.isUser? double.parse(trackingModel.clientLong??'0'):double.parse(trackingModel.storeLong??'0'),
            ) ,
          ),
        ),

        // 2. Back Button Overlay
        Positioned(
          top: 50,
          left: 20,
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              key: const Key('map_tracking_back_button'),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        // 3. Address Bottom Sheet
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(//2
            height: MediaQuery.of(context).size.height * 0.45,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(//3
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                choosableEnum==ChoosableEnum.isUser?
                addressesSections(
                  viewModel.state.userAddress.data??'',
                 viewModel. state.storeAddress.data??''
                )[0]:addressesSections(
                    viewModel.state.userAddress.data??'',
                    viewModel.state.storeAddress.data??''
                )[1],
                const SizedBox(height: 20),
                choosableEnum==ChoosableEnum.isUser?
                addressesSections(
                    viewModel.state.userAddress.data??'',
                    viewModel.state.storeAddress.data??''
                )[1]:addressesSections(
                    viewModel.state.userAddress.data??'',
                    viewModel.state.storeAddress.data??'')[0],
              ],
            ),
          ),
        ),
      ],
    );

  }
  List<Widget> addressesSections(String userAddress,String storeAddress) {
    return [
    AddressSection(
      label:AppLocale.userAddress.tr(),
      title:trackingModel.clientName??"" ,
      subtitle:userAddress,
      imageWidget: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        child:trackingModel.clientPhoto==null||
            trackingModel.clientPhoto!.isEmpty||!trackingModel.clientPhoto!.startsWith('http')?
        null:
        Image.network(trackingModel.clientPhoto??''),
      ),
      onWhatsAppTap: () {
        viewModel.doIntent(GoToWhatsAppIntent(trackingModel.userPhone??'',
            ""));
      },
      onPhoneTap: () {
        viewModel.doIntent(
            GoToPhoneDialerIntent(trackingModel.userPhone ?? ''));
      }

    ),
    AddressSection(
      label:AppLocale.pickupAddress.tr(),
      title:trackingModel.storeName??"",
      subtitle:storeAddress,
      imageWidget: CircleAvatar(
        backgroundImage:trackingModel.storePhoto==null||trackingModel.storePhoto!.isEmpty||!trackingModel.storePhoto!.startsWith('http')?
        null: NetworkImage(trackingModel.storePhoto??''),
      ),
      onWhatsAppTap: () {
        viewModel.doIntent(GoToWhatsAppIntent(trackingModel.storePhone??'',
            ""));
      },
      onPhoneTap: () {
        viewModel.doIntent(
            GoToPhoneDialerIntent(trackingModel.storePhone ?? ''));
      },
      isAddressLoading: viewModel.state.storeAddress.isLoading==true,
      isAddressError: viewModel.state.storeAddress.error!=null,
      addressError: viewModel.state.storeAddress.error.toString(),
    ),
  ];
  }
  Widget _buildMap({required double driverLat,required double driverLng,
    required double addressLat,required double addressLng}){
    return FlutterMap(
      options:  MapOptions(
        initialCenter: LatLng(driverLat, driverLng), // Cairo coordinates
        initialZoom: 14.5,
      ),
      children: [
        // 1. The actual Map Layer (OpenStreetMap)
        TileLayer(
          urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.your_app.name', // Required by OSM policy
        ),

        // 2. The Route Line (Polyline)
        PolylineLayer(
          polylines: [
            Polyline(
              points: [
                 LatLng(driverLat, driverLng),
                 LatLng(addressLat, addressLng),
              ],
              color:AppColors.primaryColor, // Your Figma Pink
              strokeWidth: 4.0,
              // isDotted: false, // Set to true if it's a dotted line in Figma
              strokeCap: StrokeCap.round, // Makes the ends of the line rounded
              strokeJoin: StrokeJoin.round, // Makes turns smooth
            ),
          ],
        ),

        // 3. The Pins (Markers)
        MarkerLayer(
          markers: [
            Marker(
              point:  LatLng(driverLat, driverLng),
              width: 50,
              height: 50,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: const Icon(Icons.local_florist, color: Colors.white, size: 25),
              ),
            ),
            Marker(
              point: LatLng(addressLat,addressLng),
              width: 50,
              height: 50,
              child: Container(
                decoration: const BoxDecoration(
                  color:AppColors.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: const Icon(Icons.store, color: Colors.white, size: 25),
              ),
            ),

          ],
        ),
      ],
    );
  }

}

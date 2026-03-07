import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressSection extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;
  final Widget imageWidget;
  final bool isAddressLoading;
  final bool isAddressError;
  final void Function()? onWhatsAppTap;
  final void Function()? onPhoneTap;
  final String? addressError;



  const AddressSection({
    super.key,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.imageWidget,
    this.onWhatsAppTap,
    this.onPhoneTap,
    this.isAddressLoading = false,
    this.isAddressError = false,
    this.addressError
  });

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color:AppColors.blackColor.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              SizedBox(width: 50, height: 50, child: imageWidget),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    isAddressLoading?
                    CircularProgressIndicator(color: AppColors.primaryColor,):
                        isAddressError?
                     Text(addressError??'',style: TextStyle(color: Colors.red),):
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16, color: Colors.black),
                        const SizedBox(width: 5),
                        Expanded(child: Text(subtitle, style: const TextStyle(color: Colors.black87, fontSize:10))),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                  onTap: onPhoneTap,
                  child: const Icon(Icons.phone_outlined, color: AppColors.primaryColor)),
              const SizedBox(width: 15),
              InkWell(
                  onTap: onWhatsAppTap,
                  child: const Icon(FontAwesomeIcons.whatsapp, color: AppColors.primaryColor)),
            ],
          ),
        ),
      ],
    );
  }
}

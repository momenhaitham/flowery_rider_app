import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleTypeDropdown extends StatelessWidget {
  final List<VehicleEntity> vehicles;
  final VehicleEntity? selectedVehicle;
  final bool isLoading;
  final Function(VehicleEntity?) onChanged;

  const VehicleTypeDropdown({
    super.key,
    required this.vehicles,
    required this.selectedVehicle,
    required this.isLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'vehicle_type'.tr(),
          style: TextStyle(
            fontSize: FontSize.s12,
            color: AppColors.grayColor,
            fontFamily: FontsFamily.inter,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grayColor, width: 1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : DropdownButtonHideUnderline(
                  child: DropdownButton<VehicleEntity>(
                    isExpanded: true,
                    value: selectedVehicle,
                    hint: Text(
                      'car'.tr(),
                      style: TextStyle(
                        fontSize: FontSize.s16,
                        color: AppColors.blackColor,
                        fontFamily: FontsFamily.inter,
                      ),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.blackColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    items: vehicles
                        .map(
                          (vehicle) => DropdownMenuItem<VehicleEntity>(
                            value: vehicle,
                            child: Text(
                              vehicle.vehicleType ?? '',
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                color: AppColors.blackColor,
                                fontFamily: FontsFamily.inter,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountrySelector extends StatelessWidget {
  final CountryEntity? selectedCountry;
  final List<CountryEntity> countries;
  final bool isLoading;
  final Function(CountryEntity) onCountrySelected;

  const CountrySelector({
    super.key,
    this.selectedCountry,
    required this.countries,
    required this.isLoading,
    required this.onCountrySelected,
  });

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'select_country'.tr(),
                    style: TextStyle(
                      fontSize: FontSize.s18,
                      fontWeight: FontWeights.semiBold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final isSelected = selectedCountry?.name == country.name;
                  return ListTile(
                    leading: Text(
                      country.flag ?? '',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    title: Text(
                      country.name ?? '',
                      style: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: isSelected
                            ? FontWeights.semiBold
                            : FontWeights.regular,
                        color: AppColors.blackColor,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.primaryColor)
                        : null,
                    onTap: () {
                      onCountrySelected(country);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'country'.tr(),
          style: TextStyle(
            fontSize: FontSize.s12,
            color: AppColors.grayColor,
            fontFamily: FontsFamily.inter,
          ),
        ),
        SizedBox(height: 4.h),
        InkWell(
          onTap: isLoading ? null : () => _showCountryPicker(context),
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackColor, width: 1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                if (selectedCountry != null) ...[
                  Text(
                    selectedCountry!.flag ?? '',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Text(
                    selectedCountry?.name ?? 'select_country'.tr(),
                    style: TextStyle(
                      fontSize: FontSize.s16,
                      color: selectedCountry != null
                          ? AppColors.blackColor
                          : AppColors.lightGrayColor,
                      fontFamily: FontsFamily.inter,
                    ),
                  ),
                ),
                if (isLoading)
                  SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryColor,
                    ),
                  )
                else
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.blackColor,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

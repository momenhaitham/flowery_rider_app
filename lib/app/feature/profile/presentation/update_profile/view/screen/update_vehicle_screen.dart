import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../apply_driver/presentation/view_model/apply_driver_intent.dart';
import '../../../../../apply_driver/presentation/view_model/apply_driver_state.dart';
import '../../../../../apply_driver/presentation/view_model/apply_driver_view_model.dart';
import '../../../../domain/model/driver_entity.dart';

class UpdateVehicleScreen extends StatelessWidget {
   UpdateVehicleScreen({super.key,required this.driver});
final DriverEntity driver;
final ApplyDriverViewModel applyDriverViewModel=getIt<ApplyDriverViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyDriverViewModel, ApplyDriverState>(
      bloc: applyDriverViewModel..doIntent(InitIntent()),
      builder:(context, state) {
        final uniqueVehicles = state.vehiclesState?.data?.fold<List<VehicleEntity>>([], (items, element) {
          if (!items.any((item) => item.vehicleType == element.vehicleType)) {
            items.add(element);
          }
          return items;
        }) ?? [];
        return Scaffold(
        backgroundColor:AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
          title: Text(
            AppLocale.editProfile.tr(),
            style:Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.black, size: 30),
                  onPressed: () {},
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Vehicle Type Dropdown
              _buildCustomField(
                label: "Vehicle type",
                child: Container(
                  color: Colors.red,
                  child:
                  state.vehiclesState?.isLoading==true?
                  const Center(child: CircularProgressIndicator()):
                      state.vehiclesState?.data!=null?
                  DropdownButtonFormField<VehicleEntity>(
                    initialValue:VehicleEntity(vehicleType: driver.vehicleType),
                    decoration: InputDecoration
                      (border: InputBorder.none,
                      suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.black)),
                    items:uniqueVehicles.map((value) {
                      return DropdownMenuItem<VehicleEntity>(value: value,
                          child: Text(value.vehicleType!,
                            style:Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black) ,));
                    }).toList(),
                    onChanged: (_) {

                    },
                  ):
                      Text('no bike'),
                ),
              ),
              const SizedBox(height: 20),
              // Vehicle Number Input
              _buildCustomField(
                label: "Vehicle number",
                child: TextFormField(
                  initialValue: "UP16DL0007",
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 20),
              // Vehicle License Upload
              _buildCustomField(
                label: "Vehicle license",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Photo_12345678", style: TextStyle(fontSize: 16)),
                    Icon(Icons.file_upload_outlined, color: Colors.black),
                  ],
                ),
              ),
              const Spacer(),
              // Update Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Update", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
      },
    );
  }

  // Helper widget to build the outlined container with label
  Widget _buildCustomField({required String label, required Widget child}) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      ),
      child: child,
    );
  }
}

import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/controller/vehicle_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../vehicles/domain/model/vehicle_entity.dart';

class VehiclesWidget extends StatefulWidget {
  const VehiclesWidget({super.key,
    required this.vehicleType,required this.vehicleController,
    required this.uniqueVehicles,this.onChanged});
final String vehicleType;
final VehicleController vehicleController;
final List<VehicleEntity> uniqueVehicles;
final void Function()? onChanged;
  @override
  State<VehiclesWidget> createState() => _VehiclesWidgetState();
}

class _VehiclesWidgetState extends State<VehiclesWidget> {
  @override
  void initState() {
    super.initState();
    widget.vehicleController.addListener(() {
      setState(() {

      });
    },);
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<VehicleEntity>(
      initialValue: VehicleEntity(
        vehicleType:widget.vehicleType,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,

        // Optional: Remove default padding if it's pushing your text too far
        contentPadding: EdgeInsets.zero,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
      ),
      items: widget.uniqueVehicles.map((value) {
        return DropdownMenuItem<VehicleEntity>(
          value: value,
          child: Text(
            value.vehicleType!,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (vehicleEntity) {
        widget.vehicleController.changeVehicleEntity(
          vehicleEntity
        );
        widget.onChanged?.call();
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/widget/photo_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/widget/vehicles_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_view_model.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/di/di.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/utils/helper_function.dart';
import '../../../../domain/model/driver_entity.dart';
import '../../controller/photo_controller.dart';
import '../../controller/update_controller.dart';
import '../../controller/vehicle_controller.dart';
import '../../view_model/update_profile_event.dart';
import '../../view_model/update_profile_intent.dart';
import '../../view_model/update_profile_state.dart';
import '../widget/update_button_widget.dart';

class UpdateVehicleScreen extends StatefulWidget {
  const UpdateVehicleScreen({super.key, required this.driver});
  final DriverEntity driver;

  @override
  State<UpdateVehicleScreen> createState() => _UpdateVehicleScreenState();
}

class _UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
  final UpdateProfileViewModel _viewModel = getIt<UpdateProfileViewModel>();

  TextEditingController vehicleNumberController = TextEditingController();
  PhotoController photoController=PhotoController();
  VehicleController vehicleController = VehicleController();
  UpdateController updateController = UpdateController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel.cubitStream.listen((event) {
      switch (event) {
        case NavigateToProfileEvent():
          if (mounted) {
            Navigator.pop(context);
          }
          break;
        case NavigateToChangePasswordEvent():
         break;
      }
    });
    vehicleController.changeVehicleEntity(VehicleEntity(vehicleType: widget.driver.vehicleType));
    vehicleNumberController.text = widget.driver.vehicleNumber??'';
    photoController.addListener(() {
      setState(() {

      });
    },);

}
@override
  void dispose() {
  super.dispose();
    vehicleNumberController.dispose();
    photoController.dispose();
    vehicleController.dispose();
    updateController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileViewModel, UpdateProfileState>(
      bloc: _viewModel..doIntent(UpdateVehicleInitIntent()),
      listener: (context, state) {
        if (state.profileState.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocale.updateProfile} ${state.profileState.data!}',
              ),
            ),
          );
          _viewModel.doIntent(NavigateToProfileAction());
        }
        if (state.profileState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocale.update_profile_error} ${getException(state.profileState.error!)}',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final uniqueVehicles =
            state.vehiclesState?.data?.fold<List<VehicleEntity>>([], (
              items,
              element,
            ) {
              if (!items.any(
                (item) => item.vehicleType == element.vehicleType,
              )) {
                items.add(element);
              }
              return items;
            }) ??
            [];
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(onPressed: () {
              _viewModel.doIntent(NavigateToProfileAction());
            },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
            title: Text(
              AppLocale.editVehicle.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.black),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                // Vehicle Type Dropdown
                _buildCustomField(
                  label: AppLocale.vehicleType.tr(),
                  child: state.vehiclesState?.isLoading == true
                      ? const Center(child: CircularProgressIndicator())
                      : state.vehiclesState?.data != null
                      ?VehiclesWidget(
                    vehicleController: vehicleController,
                    vehicleType:widget.driver.vehicleType!,
                    uniqueVehicles: uniqueVehicles,
                    onChanged: (){
                      if(isChanged()){
                        updateController.changeIsUpdate(true);
                      }else{
                        updateController.changeIsUpdate(false);
                      }
                    }
                  ) : const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),
                TextFormField(

                  controller: vehicleNumberController,
                  onChanged: (value) {
                    if (isChanged()) {
                      updateController.changeIsUpdate(true);
                    }
                    else {
                      updateController.changeIsUpdate(false);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: AppLocale.vehicleNumber.tr(),
                  ),
                ),

                const SizedBox(height: 20),
                // Vehicle License Upload
                _buildCustomField(
                  label: AppLocale.vehicleLicense.tr(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        photoController.photoFile!=null?
                            photoController.photoFile?.path.substring(86)??''
                        :widget.driver.vehicleLicense?.substring(75) ?? ''
                        ,
                        style: TextStyle(fontSize: 16),
                      ),
                      PhotoWidget(photoController:photoController ,
                          photoUrl: widget.driver.photo??'',isProfile: false,
                      onChanged: () {
                        if (isChanged()) {
                          updateController.changeIsUpdate(true);
                        } else {
                          updateController.changeIsUpdate(false);
                        }
                      },
                      )
                    ],
                  ),
                ),
                const Spacer(),
                // Update Button
                UpdateButtonWidget(onPressed: () {
                  ApplyDriverRequest request = ApplyDriverRequest(
                          vehicleType: vehicleController.vehicleEntity?.vehicleType,
                          vehicleNumber: vehicleNumberController.text,
                          vehicleLicenseImage: photoController.photoFile,
                        );
                        _viewModel.doIntent(
                          UpdateProfileAction(request, isFormData: true),
                        );
                },
                  updateController:updateController,)


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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
      ),
      child: child,
    );
  }
  bool isChanged(){
  if(photoController.photoFile!=null||vehicleController.vehicleEntity?.vehicleType!=widget.driver.vehicleType||
      vehicleNumberController.text!=widget.driver.vehicleNumber
  ){
    return true;
  }else{
    return false;
  }
  }
}

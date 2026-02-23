
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/widget/gender_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/widget/photo_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/widget/update_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/app_locale/app_locale.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/helper_function.dart';
import '../../../../../core/validation/app_validators.dart';
import '../../../domain/model/driver_entity.dart';
import '../../../domain/request/update_profile_request.dart';
import '../../profile/view/widget/notification_widget.dart';
import '../controller/gender_controller.dart';
import '../controller/photo_controller.dart';
import '../controller/update_controller.dart';
import '../view_model/update_profile_event.dart';
import '../view_model/update_profile_intent.dart';
import '../view_model/update_profile_state.dart';
import '../view_model/update_profile_view_model.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({super.key, required this.driver});

  final DriverEntity driver;

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GenderController genderController = GenderController();
  final PhotoController photoController = PhotoController();
  final UpdateProfileViewModel updateProfileViewModel =
      getIt<UpdateProfileViewModel>();
  final UpdateController updateController = UpdateController();
  List<Widget> stars = [];
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    updateProfileViewModel.cubitStream.listen((event) {
      switch (event) {
        case NavigateToProfileEvent():
          if (mounted) {
            Navigator.pop(context);
          }
          break;
        case NavigateToChangePasswordEvent():
          if (mounted) {
            Navigator.of(context, rootNavigator: true).pushNamed(
                Routes.changePasswordScreen);
          }
      }
    });
    firstNameController.text = widget.driver.firstName ?? '';
    lastNameController.text = widget.driver.lastName ?? '';
    emailController.text = widget.driver.email ?? '';
    phoneController.text = widget.driver.phone ?? '';
    genderController.changeGender(widget.driver.gender ?? '');
    stars = List.generate(6, (index) {
      return Icon(Icons.star);
    });
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    genderController.dispose();
    photoController.dispose();
    updateController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<UpdateProfileViewModel, UpdateProfileState>(
      bloc: updateProfileViewModel,
      listener: (context, state) {
        if (state.profileState.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocale.update_profile} ${state.profileState.data!}',
              ),
            ),
          );
          updateProfileViewModel.doIntent(NavigateToProfileAction());
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
        if (state.profilePhotoState.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocale.uploading_photo} ${state.profilePhotoState.data!}',
              ),
            ),
          );
          updateProfileViewModel.doIntent(NavigateToProfileAction());
        }
        if (state.profilePhotoState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocale.uploading_photo_error} ${getException(state.profilePhotoState.error!)}',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 25,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updateProfileViewModel.doIntent(
                            NavigateToProfileAction(),
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Text(AppLocale.edit_profile),
                      Spacer(),
                      NotificationWidget(),
                    ],
                  ),
                  Center(
                    child: PhotoWidget(
                      photoController: photoController,
                      photoUrl: widget.driver.photo ?? '',
                      onChanged: () {
                        if (photoController.photoFile != null) {
                          updateController.changeIsUpdate(true);
                        } else {
                          updateController.changeIsUpdate(false);
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            if (value != widget.driver.firstName) {
                              updateController.changeIsUpdate(true);
                            } else {
                              updateController.changeIsUpdate(false);
                            }
                          },
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: AppLocale.firstName,
                          ),
                          validator: (value) =>
                              AppValidators.validateFirstName(value, context),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            if (value != widget.driver.lastName) {
                              updateController.changeIsUpdate(true);
                            } else {
                              updateController.changeIsUpdate(false);
                            }
                          },
                          controller: lastNameController,
                          decoration: InputDecoration(
                            labelText: AppLocale.lastName,
                          ),
                          validator: (value) =>
                              AppValidators.validateLastName(value, context),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value != widget.driver.email) {
                        updateController.changeIsUpdate(true);
                      } else {
                        updateController.changeIsUpdate(false);
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: AppLocale.email,
                    ),
                    validator: (value) =>
                        AppValidators.validateEmail(value, context),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value != widget.driver.phone) {
                        updateController.changeIsUpdate(true);
                      } else {
                        updateController.changeIsUpdate(false);
                      }
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: AppLocale.phoneNumber,
                    ),
                    validator: (value) =>
                        AppValidators.validateNumberPhone(value, context),
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: AppLocale.password,
                      suffix: TextButton(
                        onPressed: () {
                          updateProfileViewModel.doIntent(
                            NavigateToChangePasswordAction(),
                          );
                        },
                        child: Text(
                          AppLocale.change,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                      prefix: Row(children: stars),
                    ),
                  ),
                  GenderWidget(
                    genderController: genderController,
                    onChanged: () {
                      if (genderController.gender != widget.driver.gender) {
                        updateController.changeIsUpdate(true);
                      } else {
                        updateController.changeIsUpdate(false);
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  UpdateButtonWidget(
                    updateController: updateController,
                    onPressed: () {
                      if (!(formKey.currentState?.validate() ?? false)) return;
                      final request = UpdateProfileRequest(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        gender: genderController.gender,
                      );
                      if (isChangedData()) {
                        updateProfileViewModel.doIntent(
                          UpdateProfileAction(request),
                        );
                      }
                      if (photoController.photoFile != null) {
                        updateProfileViewModel.doIntent(
                          UploadProfilePhotoAction(photoController.photoFile!),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isChangedData() {
    if (firstNameController.text != widget.driver.firstName ||
        lastNameController.text != widget.driver.lastName ||
        emailController.text != widget.driver.email ||
        phoneController.text != widget.driver.phone ||
        genderController.gender != widget.driver.gender) {
      return true;
    }
    return false;
  }
}

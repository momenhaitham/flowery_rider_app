import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/show_dialog_utils.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flowery_rider_app/app/core/validation/app_validators.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_event.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_intent.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_view_model.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/widgets/country_selector_widget.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/widgets/custom_text_form_field.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/widgets/gender_selection_widget.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/widgets/image_upload_field.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/widgets/vehicle_type_dropdown.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ApplyDriverScreen extends StatefulWidget {
  const ApplyDriverScreen({super.key});

  @override
  State<ApplyDriverScreen> createState() => _ApplyDriverScreenState();
}

class _ApplyDriverScreenState extends State<ApplyDriverScreen> {
  final _viewModel = getIt<ApplyDriverViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  CountryEntity? _selectedCountry;
  VehicleEntity? _selectedVehicle;
  String? _selectedGender;
  File? _vehicleLicenseImage;
  File? _idImage;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _viewModel.doIntent(InitIntent());
    _viewModel.streamController.stream.listen(_handleEvent);
  }

  void _handleEvent(ApplyDriverEvent event) {
    switch (event) {
      case ApplyDriverLoadingEvent():
        ShowDialogUtils.showLoading(context);
        break;
      case ApplyDriverErrorEvent():
        ShowDialogUtils.hideLoading(context);
        ShowDialogUtils.showMessage(
          context,
          title: AppLocale.error.tr(),
          content: getException(context, event.errorMessage),
        );
        break;
      case NavigateToLoginEvent():
        ShowDialogUtils.hideLoading(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.applicationSuccess,
          (route) => false,
        );
        break;
    }
  }

  Future<void> _pickImage(bool isVehicleLicense) async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() {
        if (isVehicleLicense) {
          _vehicleLicenseImage = File(image.path);
        } else {
          _idImage = File(image.path);
        }
      });
    }
  }

  bool _validateForm() {
    if (!(_formKey.currentState?.validate() ?? false)) return false;

    final validations = [
      (_selectedCountry == null, AppLocale.country_required.tr()),
      (_selectedVehicle == null, AppLocale.vehicle_type_required.tr()),
      (_selectedGender == null, AppLocale.gender_required.tr()),
      (_vehicleLicenseImage == null, AppLocale.vehicle_license_required.tr()),
      (_idImage == null, AppLocale.id_image_required.tr()),
    ];

    for (final validation in validations) {
      if (validation.$1) {
        ShowDialogUtils.showMessage(
          context,
          title: AppLocale.error.tr(),
          content: validation.$2.tr(),
        );
        return false;
      }
    }

    return true;
  }

  void _submitApplication() {
    if (!_validateForm()) return;

    final request = ApplyDriverRequest(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      rePassword: _confirmPasswordController.text,
      gender: _selectedGender,
      country: _selectedCountry?.name,
      nationalIdNumber: _idNumberController.text,
      nationalIdImage: _idImage,
      vehicleType: _selectedVehicle?.vehicleType,
      vehicleNumber: _vehicleNumberController.text,
      vehicleLicenseImage: _vehicleLicenseImage,
    );

    _viewModel.doIntent(ApplyIntent(driverRequest: request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(),
      body: BlocBuilder(
        bloc: _viewModel,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(),
                  SizedBox(height: 32.h),
                  ..._buildFormFields(state),
                  SizedBox(height: 32.h),
                  _buildContinueButton(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        AppLocale.apply.tr(),
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      centerTitle: true,
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocale.welcome_apply.tr(),
          style: TextStyle(
            fontSize: FontSize.s20,
            fontWeight: FontWeights.medium,
            color: AppColors.blackColor,
            fontFamily: FontsFamily.inter,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          AppLocale.delivery_man_join.tr(),
          style: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeights.medium,
            color: AppColors.grayColor,
            fontFamily: FontsFamily.inter,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFormFields(state) {
    return [
      CountrySelector(
        selectedCountry: _selectedCountry,
        countries: state.countriesState?.data ?? [],
        isLoading: state.countriesState?.isLoading ?? false,
        onCountrySelected: (country) =>
            setState(() => _selectedCountry = country),
      ),
      SizedBox(height: 25.h),

      CustomTextFormField(
        controller: _firstNameController,
        label: AppLocale.first_legal_name.tr(),
        placeholder: AppLocale.enter_first_legal_name.tr(),
        validator: (value) => AppValidators.validateFirstName(value, context),
      ),
      SizedBox(height: 25.h),

      CustomTextFormField(
        controller: _lastNameController,
        label: AppLocale.second_legal_name.tr(),
        placeholder: AppLocale.enter_second_legal_name.tr(),
        validator: (value) => AppValidators.validateLastName(value, context),
      ),
      SizedBox(height: 25.h),

      VehicleTypeDropdown(
        vehicles: state.vehiclesState?.data ?? [],
        selectedVehicle: _selectedVehicle,
        isLoading: state.vehiclesState?.isLoading ?? false,
        onChanged: (vehicle) => setState(() => _selectedVehicle = vehicle),
      ),
      SizedBox(height: 25.h),

      CustomTextFormField(
        controller: _vehicleNumberController,
        label: AppLocale.vehicle_number.tr(),
        placeholder: AppLocale.enter_vehicle_number.tr(),
        validator: (value) => value == null || value.isEmpty
            ? AppLocale.vehicle_number_required.tr()
            : null,
      ),
      SizedBox(height: 25.h),

      ImageUploadField(
        label: AppLocale.vehicle_license.tr(),
        placeholder: AppLocale.upload_license_photo.tr(),
        image: _vehicleLicenseImage,
        onTap: () => _pickImage(true),
      ),
      SizedBox(height: 25.h),

      CustomTextFormField(
        controller: _emailController,
        label: AppLocale.email.tr(),
        placeholder: AppLocale.enter_you_email.tr(),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => AppValidators.validateEmail(value, context),
      ),
      SizedBox(height: 25.h),

      CustomTextFormField(
        controller: _phoneController,
        label: AppLocale.phone_number.tr(),
        placeholder: AppLocale.enter_phone_number.tr(),
        keyboardType: TextInputType.phone,
        validator: (value) => AppValidators.validateNumberPhone(value, context),
      ),
      SizedBox(height: 25.h),

      CustomTextFormField(
        controller: _idNumberController,
        label: AppLocale.id_number.tr(),
        placeholder: AppLocale.enter_national_id_number.tr(),
        validator: (value) => value == null || value.isEmpty
            ? AppLocale.id_number_required.tr()
            : null,
      ),
      SizedBox(height: 25.h),

      ImageUploadField(
        label: AppLocale.id_image.tr(),
        placeholder: AppLocale.upload_id_image.tr(),
        image: _idImage,
        onTap: () => _pickImage(false),
      ),
      SizedBox(height: 25.h),

      Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: _passwordController,
              label: AppLocale.password.tr(),
              placeholder: AppLocale.password.tr(),
              obscureText: !_isPasswordVisible,
              validator: (value) =>
                  AppValidators.validatePassword(value, context),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grayColor,
                ),
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),
            ),
          ),
          SizedBox(width: 17.w),
          Expanded(
            child: CustomTextFormField(
              controller: _confirmPasswordController,
              label: AppLocale.confirm_password.tr(),
              placeholder: AppLocale.confirm_password.tr(),
              obscureText: !_isConfirmPasswordVisible,
              validator: (value) => AppValidators.validateConfirmPassword(
                value,
                _passwordController.text,
                context,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.grayColor,
                ),
                onPressed: () => setState(
                  () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 25.h),

      GenderSelection(
        selectedGender: _selectedGender,
        onGenderSelected: (gender) => setState(() => _selectedGender = gender),
      ),
    ];
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: _submitApplication,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          AppLocale.continue_btn.tr(),
          style: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeights.medium,
            color: AppColors.whiteColor,
            fontFamily: FontsFamily.inter,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _vehicleNumberController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

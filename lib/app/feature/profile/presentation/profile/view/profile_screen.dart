import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/widget/language_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/widget/logout_dialog.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/widget/profile_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/di/di.dart';
import '../view_model/profile_intent.dart';
import '../view_model/profile_state.dart';
import '../view_model/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel viewModel = getIt<ProfileViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.doIntent(GetProfileAction());
    viewModel.cubitStream.listen((event) {
      switch(event) {
        case NavigateToEditProfileOrVehicleScreen():
          if(mounted) {
            Navigator.pushNamed(context,event.isProfile?
            Routes.updateProfileScreen:Routes.updateVehicle,arguments: event.driverEntity)
                .then((value) {
                  viewModel.doIntent(GetProfileAction());
                });
          }
          case ShowLogoutDialogEvent():
            if(mounted) {
              showDialog(context: context, builder:(context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: LogoutDialog(),
                );
              },);
            }
            break;
        case ShowLanguageDialogEvent():
          if (mounted) {
            showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              showDragHandle: true,
              backgroundColor: AppColors.whiteColor,
              context: context,
              builder: (context) {
                return LanguageWidget();
              },
            );
          }
      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileState>(
      bloc: viewModel,
      builder: (context, state) =>
          ProfileWidget(profileViewModel: viewModel, profileState: state),
    );
  }
}

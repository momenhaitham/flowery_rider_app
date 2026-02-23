import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/widget/profile_cart_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/widget/profile_items_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/app_locale/app_locale.dart';
import '../../../../../../core/consts/app_consts.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/utils/helper_function.dart';
import '../../view_model/profile_intent.dart';
import '../../view_model/profile_state.dart';
import '../../view_model/profile_view_model.dart';
import 'notification_widget.dart';
class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
    required this.profileViewModel,
    required this.profileState,
  });

  final ProfileViewModel profileViewModel;
  final ProfileState profileState;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        key: Key('profile_safe_area'),
        child: Padding(
          key: Key('profile_padding'),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: Column(
            children: [
              Expanded(
                key: Key('profile_expanded'),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(AppLocale.profile),//1
                         const Spacer(),
                          NotificationWidget(),//2
                        ],
                      ),
                      const SizedBox(height: 20),
                      widget.profileState.profileState.isLoading == true
                          ? Center(
                          key:Key('loading_center'),
                          child: CircularProgressIndicator())
                          : widget.profileState.profileState.data != null
                          ? _buildProfileSection(widget.profileState.profileState.data!,)
                          : widget.profileState.profileState.error != null
                          ? Text(
                          getException(widget.profileState.profileState.error))
                          : Container(),
                      const SizedBox(height: 10),
                      ProfileItemsWidget(//3
                        data: AppLocale.language,
                        leading: Icon(Icons.translate),
                        trailing: Text(//4
                            AppLocale.english ,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                              color: AppColors.primaryColor,
                            )),
                      ),
                      const SizedBox(height: 10),

                      ProfileItemsWidget(//5
                        data: AppLocale.logout,
                        leading: Icon(Icons.logout),
                        trailing: Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                AppConsts.appVersion,
                style: Theme
                    .of(
                  context,
                )
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColors.grayColor),
              ),//6
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection( DriverEntity driver,{ProfileViewModel? profileViewModel}) {
    return Column(
      children: [
       ProfileCartWidget(
         onTap: () => profileViewModel?.doIntent(NavigateToEditProfileIntent(driver)),
         photoUrl:driver.photo??'' , title:'${driver.firstName??''} ${driver.lastName??''}',
           subtitle: driver.email??'', subSubTitle: driver.phone??'',),
        const SizedBox(height: 10),
       ProfileCartWidget(title:'vehicle info', subtitle: driver.vehicleType??'', subSubTitle: driver.vehicleNumber??'',)
      ],
    );
  }
}

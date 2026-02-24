import 'package:flutter/material.dart';

import '../../../../../../core/consts/app_consts.dart';
import '../../../../../../core/resources/app_colors.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.topRight,
      children: [
        Icon(Icons.notifications_none),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(2),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            AppConsts.notificationNumber,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 8,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

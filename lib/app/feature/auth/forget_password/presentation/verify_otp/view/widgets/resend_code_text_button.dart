import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
class ResendCodeTextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResendCodeTextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(AppLocale.receiveCodeQuestion.tr(),
        style: Theme
            .of(context)
            .textTheme
            .bodyLarge,
      ),
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(
            AppLocale.resend.tr(),
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
            )

        ),
      ),
    ],
  );
}

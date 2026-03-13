import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flowery_rider_app/app/core/resources/values_manager.dart';
import 'package:flowery_rider_app/app/core/theme/app_theme.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/views/screen/login/controller/remember_controller.dart';

class RememberMeWidget extends StatefulWidget {
  const RememberMeWidget({super.key, required this.rememberController});

  final RememberController rememberController;

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  @override
  void initState() {
    super.initState();
    widget.rememberController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          Checkbox(
            value: widget.rememberController.rememberMe,
            onChanged: (value) {
              widget.rememberController.changeRememberMe();
            },
          ),
          Flexible(
            child: Text(
              'rememberMe'.tr(),
              style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                fontSize: AppSize.s14,
                fontWeight: FontWeights.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

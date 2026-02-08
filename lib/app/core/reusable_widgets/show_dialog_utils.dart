
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ShowDialogUtils {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("loading".tr(), style: Theme.of(context).textTheme.headlineMedium),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          backgroundColor: Colors.white,
        );
      },
      barrierDismissible: false,
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
    BuildContext context, {
    String? title,
    String? content,
    String? posActionName,
    Function? posAction,
    String? nigActionName,
    Function? nigAction,
  }) {
    List<Widget> actions = [];

    if (posActionName != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            posAction == null ? Navigator.pop(context) : posAction.call();
          },
          child: Text(posActionName, style:Theme.of(context).textTheme.headlineMedium),
        ),
      );
    }
    if (nigActionName != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            nigAction == null ? Navigator.pop(context) : nigAction.call();
          },
          child: Text(nigActionName, style: Theme.of(context).textTheme.headlineMedium),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? "", style: Theme.of(context).textTheme.headlineMedium),
          content: Text(content ?? '', style: Theme.of(context).textTheme.headlineMedium),
          actions: actions,
          backgroundColor: Colors.white,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../app_locale/app_locale.dart';
import '../resources/app_colors.dart';


class AppDialog {
  static void viewDialog(
    BuildContext context,
    String message, {
    String? acceptText,
    String? cancelText,
    Function? acceptAction,
    Function? cancelAction,
  }) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:AppColors.whiteColor,
          elevation: 30,
          contentPadding: EdgeInsets.zero,
          content: message.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 10),
                      Text(AppLocale.loading),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(message, textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: acceptText != null,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  if (acceptAction != null) {
                                    acceptAction();
                                  }
                                },
                                child: Text(acceptText ?? ''),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Visibility(
                              visible: cancelText != null,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  if (cancelAction != null) {
                                    cancelAction();
                                  }
                                },
                                child: Text(cancelText ?? ''),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  static void viewCustomDialogue(BuildContext context,
      Widget child) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: 30,
            contentPadding: EdgeInsets.zero,
            content: child
        );
      },
    );
  }
}

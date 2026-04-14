import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/resources/app_colors.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  Widget build(BuildContext context) {
    var startViewModel = Provider.of<AppProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocale.changeLanguage.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    AppLocale.arabic.tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocale.english.tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              RadioGroup<String>(
                groupValue: startViewModel.currentLocale,
                onChanged: (val) {
                  startViewModel.changeLocale(context, val!);
                },
                child: Column(
                  children: [
                    Radio<String>(
                      value: 'ar',

                    ),
                    Radio<String>(
                      value: 'en',

                    ),
                  ],
                ),
              )
            ],
          ),
          // LanguageContainerWidget(
          //   value: 'ar',
          //   title: AppLocale(context).arabic,
          // ),
          // const SizedBox(height: 10),
          // LanguageContainerWidget(
          //   value: 'en',
          //   title: AppLocale(context).english,
          // ),
        ],
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../../../core/app_locale/app_locale.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../controller/gender_controller.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({
    super.key,
    required this.genderController,
    this.onChanged,
  });

  final GenderController genderController;
  final void Function()? onChanged;

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  @override
  void initState() {
    super.initState();
    widget.genderController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(AppLocale.gender,)),
        Expanded(
          child: RadioListTile<String>(
            title: Text(AppLocale.female,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 16
                )
            ),
            value: AppLocale.female.toLowerCase(),
            groupValue: widget.genderController.gender.toLowerCase(),
            onChanged: (value) {
              widget.genderController.changeGender(value!);
              widget.onChanged?.call();
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: Text(AppLocale.male),
            value: AppLocale.male.toLowerCase(),
            groupValue: widget.genderController.gender.toLowerCase(),
            onChanged: (value) {
              widget.genderController.changeGender(value!);
              widget.onChanged?.call();
            },
          ),
        ),
      ],
    );
  }
}

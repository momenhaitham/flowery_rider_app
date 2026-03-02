import 'package:flutter/material.dart';

class ProfileItemsWidget extends StatelessWidget {
  const ProfileItemsWidget({
    super.key,
    required this.data,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String data;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 0,
      leading: leading,
      title: Text(data),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios),
    );
  }
}

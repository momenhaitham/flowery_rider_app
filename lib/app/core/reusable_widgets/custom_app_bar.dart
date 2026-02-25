import 'package:flutter/material.dart';

import 'back_arrow_icon.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onLeadingIconClicked;
final String text;
  const CustomAppBar({super.key, required this.onLeadingIconClicked,required this.text});

  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    leading: IconButton(
      onPressed: onLeadingIconClicked,
      icon: const BackArrowIcon(),
    ),
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../../core/resources/app_colors.dart';
class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({super.key, required this.photoUrl, this.photoFile});
  final String photoUrl;
  final File? photoFile;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: photoFile != null
          ? FileImage(photoFile!)
          :photoUrl.isEmpty||!photoUrl.startsWith('http')?
      null:
      NetworkImage(photoUrl),
      backgroundColor: AppColors.transparentColor,
    );
  }
  Widget buildProfileImage(String photoUrl) {
    if (photoUrl.isEmpty || !photoUrl.startsWith('http')) {
      return const CircleAvatar(
        child: Icon(Icons.person),
      );
    }

    return CircleAvatar(
      backgroundImage: NetworkImage(photoUrl),
    );
  }
}

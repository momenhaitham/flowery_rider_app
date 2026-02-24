import 'package:flutter/material.dart';

import '../../../profile/view/widget/profile_photo_widget.dart';
import '../../controller/photo_controller.dart';

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({
    super.key,
    required this.photoController,
    required this.photoUrl,
    this.onChanged,
  });

  final PhotoController photoController;
  final String photoUrl;
  final void Function()? onChanged;

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  @override
  void initState() {
    super.initState();
    widget.photoController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomRight,
      children: [
        ProfilePhotoWidget(
          photoUrl: widget.photoUrl,
          photoFile: widget.photoController.photoFile,
        ),
        IconButton(
          onPressed: () async {
            await widget.photoController.changePhoto();
            widget.onChanged?.call();
          },
          icon: Icon(Icons.camera_alt_outlined),
        ),
      ],
    );
  }
}

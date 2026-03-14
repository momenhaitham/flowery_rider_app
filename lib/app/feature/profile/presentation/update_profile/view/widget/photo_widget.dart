import 'package:flutter/material.dart';

import '../../../profile/view/widget/profile_photo_widget.dart';
import '../../controller/photo_controller.dart';

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({
    super.key,
    required this.photoController,
    required this.photoUrl,
    this.onChanged,
    this.isProfile=true,
  });

  final PhotoController photoController;
  final String photoUrl;
  final void Function()? onChanged;
  final bool isProfile;


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
       widget.isProfile? ProfilePhotoWidget(
          photoUrl: widget.photoUrl,
          photoFile: widget.photoController.photoFile,
         ):SizedBox.shrink()
      // Text(
        //   widget.photoController.photoFile!=null?
        //   widget.photoController.photoFile?.path.substring(86)??''
        //       :widget.photoUrl.substring(75)
        //   ,
        //   style: TextStyle(fontSize: 16),
        // )
        ,
        IconButton(
          onPressed: () async {
            await widget.photoController.changePhoto();
            widget.onChanged?.call();
          },
          icon:widget.isProfile? Icon(Icons.camera_alt_outlined):
          Icon(Icons.file_upload_outlined, color: Colors.black),

        ),
      ],
    );
  }
}

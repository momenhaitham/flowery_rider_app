import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PhotoController extends ChangeNotifier {
  File? photoFile;

  Future<void> changePhoto() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      photoFile = File(file.path);
    }
    notifyListeners();
  }
}

import 'dart:io';

import 'package:chat_app2/services/dialog_service.dart';
import 'package:chat_app2/services/get_image_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PopUps {
  PopUps._();

  static Future<File?> showCameraGalleryPopup(BuildContext context) async {
    File? image;

    final List<Widget> actions = [
      CupertinoActionSheetAction(
        onPressed: () async {
          final XFile? file = await GetImageService().getImageFromCamera();

          if (file == null) return;

          image = File(file.path);

          Navigator.of(context).pop();
        },
        child: const Text('Camera'),
      ),
      CupertinoActionSheetAction(
        onPressed: () async {
          final XFile? file = await GetImageService().getImageFromGallery();

          if (file == null) return;

          image = File(file.path);

          Navigator.of(context).pop();
        },
        child: const Text('Gallery'),
      ),
    ];

    await DialogService().showMenu(
      context: context,
      actions: actions,
    );

    return image;
  }
}

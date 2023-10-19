import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MAImageProvider with ChangeNotifier {
  String? fileType;
  ImagePicker? picker;
  String? fileSize;
  XFile? image;
  File? showImage;
  int? size;
  Uint8List? bytes;

  Future pickImage(ImageSource source) async {
    picker = ImagePicker();
    image = await picker!.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      // maxHeight: ,
      // maxWidth: ,
    );
    showImage = File(image!.path);
    bytes = showImage!.readAsBytesSync();
    size = showImage!.readAsBytesSync().lengthInBytes;
    final kb = size! / 1024;
    final mb = kb / 1024;
    fileSize = mb.toString().substring(0, 4);
    fileType = image!.name.toString().split('.').last;
    print('image!.path=${image!.path}');
    print('fileName=$fileType');
    print('image!.mb=$mb');
    print('image!.kb=$kb');
    notifyListeners();
  }
}

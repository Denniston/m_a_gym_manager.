import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

// class ImagePickerWidget extends StatelessWidget {
//   final Function(XFile image) onImageSelected;
//
//   const ImagePickerWidget({
//     super.key,
//     required this.onImageSelected,
//   });
//   Future<File?> _getImage(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? returnedImage = await _picker.pickImage(source: source);
//     if (returnedImage != null) {
//       // Convert the XFile to a File object.
//       final File image = File(returnedImage.path);
//
//       // Convert the image to a text string.
//       final String imageString = base64Encode(image.readAsBytesSync());
//
//       // final String imageString = base64Encode(
//       //   (await image.readAsBytes()).then((bytes) => bytes),
//       // );
//       // Save the image string to the database.
//       final db = await openDatabase('gym.db');
//       await db.insert('images', {
//         'image': imageString,
//       });
//
//       // Return the File object.
//       return image;
//     }
//     return null;
//   }
//
//   Future<XFile> _pickImage() async {
//     ImageSource imageSource = ImageSource.camera;
//
//     final pickedFile = await ImagePicker.pickImage(
//       source: imageSource,
//     );
//
//     if (pickedFile != null) {
//       onImageSelected(pickedFile);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: _pickImage,
//       tooltip: 'Pick Image',
//       child: const Icon(Icons.add_a_photo),
//     );
//   }
// }
class GetImage extends StatelessWidget {
  final ImageSource source;

  GetImage(this.source);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: getImage(source),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.file(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<File?> getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? returnedImage = await _picker.pickImage(source: source);
    if (returnedImage != null) {
      final File image = File(returnedImage.path);
      final String imageString = base64Encode(image.readAsBytesSync());
      return image;
    }
    return null;
  }
}

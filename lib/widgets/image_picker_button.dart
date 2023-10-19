// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
//
// class ImagePickerButton extends StatefulWidget {
//   final Function(File?) onImageSelected;
//
//   ImagePickerButton({required this.onImageSelected});
//
//   @override
//   _ImagePickerButtonState createState() => _ImagePickerButtonState();
// }
//
// class _ImagePickerButtonState extends State<ImagePickerButton> {
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _getImage(ImageSource source) async {
//     File mage;
//     try {
//       final pickedFile = await _picker.pickImage(source: source);
//       if (pickedFile != null) {
//         final File image = File(pickedFile.path);
//         widget
//             .onImageSelected(image); // Pass the selected image to the callback
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             ElevatedButton(
//               onPressed: () => _getImage(ImageSource.camera),
//               child: Text('Take a Picture'),
//             ),
//             ElevatedButton(
//               onPressed: () => _getImage(ImageSource.gallery),
//               child: Text('Pick from Gallery'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16.0),
//         image != null
//             ? Image.file(image!)
//             : const Text('Please Select An Image.'),
//         const SizedBox(height: 32.0),
//       ],
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  final Function(File?) onImageSelected;
  final String? initialImageString;

  ImagePickerButton(
      {required this.onImageSelected,
      this.initialImageString,
      required String initialImage});

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  String imageToString(File imageFile) {
    final bytes = imageFile.readAsBytesSync();
    return base64Encode(bytes);
  }

  File stringToImage(String encodedString, String fileName) {
    final bytes = base64Decode(encodedString);
    final File imageFile = File(fileName);
    imageFile.writeAsBytesSync(bytes);
    return imageFile;
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialImageString != null) {
      // If an initial image string is provided, convert it to a File
      _selectedImage =
          stringToImage(widget.initialImageString!, 'initial_image.png');
    }
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final File image = File(pickedFile.path);
        setState(() {
          _selectedImage = image; // Set the selected image in the state
        });
        widget
            .onImageSelected(image); // Pass the selected image to the callback
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.camera),
              child: const Icon(Icons.camera),
            ),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: const Icon(Icons.photo_library),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _selectedImage != null
            ? Image.file(_selectedImage!) // Display the selected image
            : const Text('Please Select An Image.'),
        const SizedBox(height: 32.0),
      ],
    );
  }
}

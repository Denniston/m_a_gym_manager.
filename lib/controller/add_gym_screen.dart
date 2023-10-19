// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../model/gym.dart';
// // import 'appstate.dart';
// //
// // class AddGymScreen extends StatelessWidget {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _addressController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Add Gym'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             TextField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(labelText: 'Gym Name'),
// //             ),
// //             const SizedBox(height: 16.0),
// //             TextField(
// //               controller: _addressController,
// //               decoration: const InputDecoration(labelText: 'Location'),
// //             ),
// //             const SizedBox(height: 32.0),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 final String name = _nameController.text;
// //                 final String address = _addressController.text;
// //
// //                 if (name.isNotEmpty && address.isNotEmpty) {
// //                   final gym = Gym(
// //                     name: name,
// //                     address: address,
// //                   );
// //
// //                   await Provider.of<AppState>(context, listen: false)
// //                       .insertGym(gym);
// //
// //                   Navigator.pop(context);
// //                 }
// //               },
// //               child: const Text('Add Gym'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //2nd try
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // import '../model/gym.dart';
// // import 'appstate.dart';
//
// // class AddGymScreen extends StatefulWidget {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _addressController = TextEditingController();
// //
// //   @override
// //   State<AddGymScreen> createState() => _AddGymScreenState();
// // }
// //
// // class _AddGymScreenState extends State<AddGymScreen> {
// //   File? _profileImage;
// //
// //   Future<void> _pickImage(ImageSource source) async {
// //     final image = await ImagePicker.pickImage(source: source);
// //
// //     setState(() {
// //       _profileImage = image;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Add Gym'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             TextField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(labelText: 'Gym Name'),
// //             ),
// //             const SizedBox(height: 16.0),
// //             TextField(
// //               controller: _addressController,
// //               decoration: const InputDecoration(labelText: 'Location'),
// //             ),
// //             const SizedBox(height: 32.0),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: Text(
// //                     'Profile Image',
// //                     style: TextStyle(fontSize: 16.0),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8.0),
// //                 IconButton(
// //                   onPressed: () => _pickImage(ImageSource.gallery),
// //                   icon: Icon(Icons.photo_library),
// //                 ),
// //                 IconButton(
// //                   onPressed: () => _pickImage(ImageSource.camera),
// //                   icon: Icon(Icons.camera_alt),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 16.0),
// //             if (_profileImage != null)
// //               Container(
// //                 height: 100.0,
// //                 width: 100.0,
// //                 child: Image.file(_profileImage!),
// //               ),
// //             const SizedBox(height: 32.0),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 final String name = _nameController.text;
// //                 final String address = _addressController.text;
// //
// //                 if (name.isNotEmpty && address.isNotEmpty) {
// //                   final gym = Gym(
// //                     name: name,
// //                     address: address,
// //                     profileImage: _profileImage?.path,
// //                   );
// //
// //                   await Provider.of<AppState>(context, listen: false)
// //                       .gymProvider
// //                       .insertGym(gym);
// //
// //                   Navigator.pop(context);
// //                 }
// //               },
// //               child: const Text('Add Gym'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //3rd try
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../model/gym.dart';
// import 'appstate.dart';
// import 'gym_provider.dart';
//
// class AddGymScreen extends StatefulWidget {
//   const AddGymScreen({super.key});
//
//   // final TextEditingController _nameController = TextEditingController();
//   // final TextEditingController _addressController = TextEditingController();
//
//   @override
//   State<AddGymScreen> createState() => _AddGymScreenState();
// }
//
// class _AddGymScreenState extends State<AddGymScreen> {
//   File? _profileImage;
//   late Gym gym;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _managerController = TextEditingController();
//
//   late ImagePicker _imagePicker;
//   @override
//   void initState() {
//     super.initState();
//     _imagePicker = ImagePicker();
//   }
//
//   // Future<File?> _getImage(ImageSource source) async {
//   //   final ImagePicker _picker = ImagePicker();
//   //   final XFile? returnedImage = await _picker.pickImage(source: source);
//   //   if (returnedImage != null) {
//   //     return File(returnedImage.path);
//   //   }
//   //   return null;
//   // }
//
//   Future<File?> _getImage(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? returnedImage = await picker.pickImage(source: source);
//     if (returnedImage != null) {
//       // Convert the XFile to a File object.
//       final File image = File(returnedImage.path);
//
//       // Convert the image to a text string.
//       final String imageString = base64Encode(image.readAsBytesSync());
//
//       String base64 = base64Encode(imageString as List<int>);
//       // final String imageString = base64Encode(
//       //   (await image.readAsBytes()).then((bytes) => bytes),
//       // );
//       // Save the image string to the database.
//       final db = await openDatabase('gym.db');
//       await db.insert('images', {
//         'image': imageString,
//       });
//
//       print(base64);
//       // Return the File object.
//       return image;
//     }
//     return null;
//   }
//
//   // void _saveImage(File image) async {
//   //   final String imageString = base64Encode(image.readAsBytesSync());
//   //
//   //   // Update the image in the database.
//   //   final AppState appState = Provider.of<AppState>(context, listen: false);
//   //   final Gym? gym = appState.gym;
//   //   gym?.profileImage = imageString;
//   //   appState.gym = gym;
//   //
//   //   // Save the updated gym to the database.
//   //   await Provider.of<GymProvider>(context, listen: false).updateGym(gym!);
//   // }
//
//   // Future<XFile?> _pickImageFromGallery() async {
//   //   var returnedImage =
//   //       await _imagePicker.pickImage(source: ImageSource.gallery);
//   //   if (returnedImage == null) ;
//   //   setState(() {
//   //     _profileImage = File(returnedImage!.path);
//   //   });
//   //   return null;
//   // }
//   //
//   // Future<XFile?> _pickImageFromCamera() async {
//   //   var returnedImage =
//   //       await _imagePicker.pickImage(source: ImageSource.camera);
//   //   if (returnedImage == null) ;
//   //   setState(() {
//   //     _profileImage = File(returnedImage!.path);
//   //   });
//   //   return null;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Gym'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Gym Name'),
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: _addressController,
//               decoration: const InputDecoration(labelText: 'Location'),
//             ),
//             const SizedBox(height: 32.0),
//             TextField(
//               controller: _managerController,
//               decoration: const InputDecoration(labelText: 'Manager'),
//             ),
//             const SizedBox(height: 32.0),
//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     'Profile Image',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ),
//                 const SizedBox(width: 8.0),
//                 IconButton(
//                   onPressed: () =>
//                       _getImage(ImageSource.gallery), //_pickImageFromGallery(),
//                   icon: const Icon(Icons.photo_library),
//                 ),
//                 IconButton(
//                   onPressed: () =>
//                       _getImage(ImageSource.camera), //_pickImageFromCamera(),
//                   icon: const Icon(Icons.camera_alt),
//                 ),
//               ],
//             ),
//             Container(height: 16.0),
//             _profileImage != null
//                 ? Image.file(_profileImage!)
//                 : const Text('Please Select An Image.'),
//             const SizedBox(height: 32.0),
//             ElevatedButton(
//               onPressed: () async {
//                 final int? id = gym.id;
//                 final String name = _nameController.text;
//                 final String address = _addressController.text;
//                 final String manager = _managerController.text;
//                 String? profileImage;
//
//                 if (name.isNotEmpty && address.isNotEmpty) {
//                   //setState(() {_saveImage(image!)});
//
//                   final gym = Gym(
//                     id: id,
//                     name: name,
//                     address: address,
//                     profileImage: profileImage,
//                     manager: manager,
//                   );
//
//                   await Provider.of<GymProvider>(context, listen: false)
//                       .addGym(gym);
//
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text('Add Gym'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

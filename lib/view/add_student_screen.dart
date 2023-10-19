// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/student_provider.dart';
// import '../model/student.dart';
//
// class AddStudentPage extends StatefulWidget {
//   @override
//   _AddStudentPageState createState() => _AddStudentPageState();
// }
//
// class _AddStudentPageState extends State<AddStudentPage> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   File? _profilePicture;
//
//   @override
//   Widget build(BuildContext context) {
//     final studentProvider = Provider.of<StudentProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Student'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _firstNameController,
//               decoration: InputDecoration(labelText: 'First Name'),
//             ),
//             TextFormField(
//               controller: _lastNameController,
//               decoration: InputDecoration(labelText: 'Last Name'),
//             ),
//             DateTimePicker(
//               controller: _dobController,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(1900),
//               lastDate: DateTime.now(),
//             ),
//             GestureDetector(
//               onTap: () {
//                 getImage();
//               },
//               child: Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: _profilePicture != null
//                     ? Image.file(_profilePicture!)
//                     : Icon(Icons.add_photo_alternate),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final student = Student(
//                   id: 0,
//                   firstName: _firstNameController.text,
//                   lastName: _lastNameController.text,
//                   dob: DateTime.parse(_dobController.text),
//                   profileImage: _profileImage,
//                   age: _age,
//                   email: _email,
//                 );
//
//                 studentProvider.addStudent(student);
//
//                 Navigator.pop(context);
//               },
//               child: Text('Add Student'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future getImage() async {
//     final image = await _imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       setState(() {
//         _profilePicture = File(image.path);
//       });
//       studentProvider.updateProfilePicture(_profilePicture!.path);
//     }
//   }
// }

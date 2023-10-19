// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../model/class.dart';
// import '../model/coach.dart';
// import '../model/gym.dart';
// import '../model/student.dart';
//
// class AddEditItemDialog extends StatefulWidget {
//   final String title;
//   final String confirmButtonText;
//   final Function(dynamic) onSave;
//
//   AddEditItemDialog({
//     required this.title,
//     required this.confirmButtonText,
//     required this.onSave,
//   });
//
//   @override
//   _AddEditItemDialogState createState() => _AddEditItemDialogState();
// }
//
// class _AddEditItemDialogState extends State<AddEditItemDialog> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _specializationController =
//   TextEditingController();
//   final TextEditingController _classNameController = TextEditingController();
//   late DateTime _selectedDate = DateTime.now();
//   PickedFile? _pickedImage;
//
//   void _selectDate() async {
//     final DateTime picked = (await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     ))!;
//
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   void _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _pickedImage = pickedImage;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.title),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(labelText: 'Location'),
//             ),
//             TextField(
//               controller: _specializationController,
//               decoration: InputDecoration(labelText: 'Specialization'),
//             ),
//             TextField(
//               controller: _classNameController,
//               decoration: InputDecoration(labelText: 'Class Name'),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Birthday: ${_selectedDate.toLocal()}'.split(' ')[0],
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: _selectDate,
//                   child: Text('Select Date'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             _pickedImage != null
//                 ? Image.file(File(_pickedImage!.path))
//                 : Text('No image selected'),
//             TextButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () async {
//             final item = _buildItem();
//
//             if (item != null) {
//               widget.onSave(item);
//               Navigator.pop(context);
//             }
//           },
//           child: Text(widget.confirmButtonText),
//         ),
//       ],
//     );
//   }
//
//   dynamic _buildItem() {
//     if (widget.title == 'Create Gym') {
//       return Gym(
//         name: _nameController.text,
//         location: _locationController.text,
//       );
//     } else if (widget.title == 'Create Coach') {
//       return Coach(
//         //name: _nameController.text,
//         specialization: _specializationController.text, firstName: '', lastName: '', email: '', grade: '', phone: '',
//       );
//     } else if (widget.title == 'Create Class') {
//       return Class(
//         coachId: 0, // Set the coach ID accordingly
//         gymId: 0,   // Set the gym ID accordingly
//         className: _classNameController.text,
//         schedule: '', // Set the schedule accordingly
//       );
//     } else if (widget.title == 'Create Student') {
//       return Student(
//         firstName: _nameController.text,
//         lastName: _locationController.text,
//         dob: _selectedDate.toLocal().toString(),
//         profilePicture: _pickedImage?.path ?? '',
//         gymId: 0, // Set the gym ID accordingly
//         classId: 0, // Set the class ID accordingly
//       );
//     }
//   }
// }

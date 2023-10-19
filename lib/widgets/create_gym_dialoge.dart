// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../controller/gym_provider.dart';
// // import '../model/gym.dart';
// //
// // class CreateGymDialog extends StatelessWidget {
// //   const CreateGymDialog(BuildContext context, {Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final TextEditingController _nameController = TextEditingController();
// //     final TextEditingController _addressController = TextEditingController();
// //
// //     return AlertDialog(
// //       title: Text('Create Gym'),
// //       content: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           TextFormField(
// //             controller: _nameController,
// //             decoration: InputDecoration(labelText: 'Name'),
// //           ),
// //           TextFormField(
// //             controller: _addressController,
// //             decoration: InputDecoration(labelText: 'Address'),
// //           ),
// //         ],
// //       ),
// //       actions: [
// //         TextButton(
// //           onPressed: () => Navigator.pop(context),
// //           child: Text('Cancel'),
// //         ),
// //         TextButton(
// //           onPressed: () async {
// //             final gymProvider =
// //                 Provider.of<GymProvider>(context, listen: false);
// //             final newGym = Gym(
// //               name: _nameController.text,
// //               address: _addressController.text,
// //             );
// //             await gymProvider.addGym(newGym);
// //             Navigator.pop(context);
// //           },
// //           child: Text('Create'),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/gym_provider.dart';
// import '../model/gym.dart';
//
// //TODO: Change from CreateGymWidget to CreateGymDialog
// class CreateGymDialog extends StatelessWidget {
//   CreateGymDialog({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _nameController = TextEditingController();
//     final TextEditingController _addressController = TextEditingController();
//     final TextEditingController _profileImageController =
//         TextEditingController(); // Add this line
//
//     return AlertDialog(
//       title: const Text('Create Gym'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             controller: _nameController,
//             decoration: const InputDecoration(labelText: 'Name'),
//           ),
//           TextFormField(
//             controller: _addressController,
//             decoration: const InputDecoration(labelText: 'Address'),
//           ),
//           TextFormField(
//             controller: _profileImageController,
//             decoration: const InputDecoration(
//                 labelText: 'Profile Image URL'), // Add this line
//           ),
//           // You can add more TextFormField widgets for other input fields here
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () async {
//             late final gymProvider =
//                 Provider.of<GymProvider>(context, listen: false);
//             final newGym = Gym(
//               name: _nameController.text,
//               address: _addressController.text,
//               profileImage: _profileImageController.text,
//               manager: '',
//               // Add this line
//               // Initialize other Gym properties here based on your model
//             );
//             await gymProvider.addGym(newGym);
//             Navigator.pop(context);
//           },
//           child: const Text('Create'),
//         ),
//       ],
//     );
//   }
// }

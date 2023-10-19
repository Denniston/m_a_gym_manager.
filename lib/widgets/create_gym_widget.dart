import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_a_gym_manager/controller/gym_provider.dart';
import 'package:m_a_gym_manager/database/gym_app_db.dart';
import 'package:provider/provider.dart';
import '../model/gym.dart';

class CreateGymWidget extends StatefulWidget {
  const CreateGymWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateGymWidget> createState() => _CreateGymWidgetState();
}

class _CreateGymWidgetState extends State<CreateGymWidget> {
  //late final ValueChanged<String> onSubmit;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _managerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

//TODO: Fix Dispose Method
  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _addressController.dispose();
  //   _managerController.dispose();
  //   super.dispose();
  // }

  // To store the selected image
  File? _profileImage;

  Future<void> _getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        //final File image = File(pickedFile.path);

        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Show a Snackbar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveGymToDatabase() async {
    if (formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text.toString();
      final address = _addressController.text;
      final manager = _managerController.text;

      // Encode the image to base64 if needed
      String? imageString;
      if (_profileImage != null) {
        try {
          imageString = base64Encode(_profileImage!.readAsBytesSync());
        } catch (e) {
          print('Error encoding image: $e');
        }
      }

      try {
        final gymProvider = Provider.of<GymProvider>(context, listen: false);
        final newGym = Gym(
          name: name,
          email: email,
          phone: int.tryParse(phone) ?? 0,
          address: address,
          profileImage: imageString,
          manager: manager,
        );

        await gymProvider.addGym(newGym);

        // Close the dialog after saving
        Navigator.pop(context);
      } catch (e) {
        print('Error saving gym to database: $e');
        // Handle the error and provide feedback to the user.
      }
    }
  }

  // Future<void> _saveGymToDatabase() async {
  //   if (formKey.currentState!.validate()) {
  //     final name = _nameController.text;
  //     final address = _addressController.text;
  //     final manager = _managerController.text;
  //
  //     // Encode the image to base64 if needed
  //     String? imageString;
  //     if (_profileImage != null) {
  //       imageString = base64Encode(_profileImage!.readAsBytesSync());
  //     }
  //     late final gymProvider = Provider.of<GymProvider>(context, listen: false);
  //     final newGym = Gym(
  //       name: name,
  //       address: address,
  //       profileImage: imageString,
  //       manager: manager,
  //     );
  //     await gymProvider.addGym(newGym);
  //
  //     // Close the dialog after saving
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //final isEditing = widget.gym != null;
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Add Gym'),
        content: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                autofocus: true,
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Gym Name'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Gym Name is Required'
                    : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(hintText: 'Gym Address'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Gym Address is Required'
                    : null,
              ),
              TextFormField(
                controller: _managerController,
                decoration: const InputDecoration(hintText: 'Gym Manager'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Gym Manager is Required'
                    : null,
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Profile Image',
                style: TextStyle(fontSize: 16.0),
              ),
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () => _getImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                  ),
                  IconButton(
                    onPressed: () => _getImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              _profileImage != null
                  ? Image.file(_profileImage!)
                  : const Text('Please Select An Image.'),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: _saveGymToDatabase,
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

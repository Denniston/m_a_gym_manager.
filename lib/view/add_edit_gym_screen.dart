import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_a_gym_manager/controller/gym_provider.dart';
import 'package:m_a_gym_manager/database/database_helper.dart';
import 'package:m_a_gym_manager/model/gym.dart';
import 'package:m_a_gym_manager/database/gym_app_db.dart';
import 'package:provider/provider.dart';

import '../widgets/image_picker_button.dart';

class AddEditGymScreen extends StatelessWidget {
  final Gym? gym;

  const AddEditGymScreen({Key? key, this.gym}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final managerController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final gymProvider = Provider.of<GymProvider>(context, listen: false);

    if (gym != null) {
      nameController.text = gym!.name;
      emailController.text = gym!.email;
      phoneController.text = gym!.phone.toString();
      addressController.text = gym!.address;
      managerController.text = gym!.manager;
    }
    Future<void> _saveGymToDatabase() async {
      if (formKey.currentState!.validate()) {
        final name = nameController.text;
        final email = emailController.text;
        final phone = phoneController.text.toString();
        final address = addressController.text;
        final manager = managerController.text;

        // Encode the image to base64 if needed
        String? imageString;
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

    File? selectedImage;

    File? profileImage;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gym == null ? 'Add a gym' : 'Edit gym',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Enter Gym Name',
                    labelText: 'Gym Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: managerController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Enter Gym Manager',
                    labelText: 'Gym Manager',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: emailController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Enter Gym Email',
                    labelText: 'Gym Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.number, // Set the keyboard type
                controller: phoneController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Enter Gym Phone Number',
                    labelText: 'Gym Phone Number',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                    hintText: 'Enter Gym Address',
                    labelText: 'Gym Address',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
                keyboardType: TextInputType.multiline,
                onChanged: (str) {},
                maxLines: 4,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Image',
                style: TextStyle(fontSize: 16.0),
              ),
              Column(
                children: [
                  const SizedBox(width: 8.0),
                  ImagePickerButton(
                    onImageSelected: (File? image) {
                      if (image != null) {
                        // Handle the selected image here

                        selectedImage = image;
                        String? imageString;
                        try {
                          imageString = base64Encode(image!.readAsBytesSync());
                        } catch (e) {
                          print('Error encoding image: $e');
                        }
                      }
                    },
                    // Replace with the actual encoded image string
                    initialImageString: '',
                    initialImage: 'assets/images/gym_image.png',
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      final name = nameController.value.text;
                      final email = emailController.value.text;
                      final phone = phoneController.value.text;
                      final address = addressController.value.text;
                      final manager = managerController.value.text;

                      if (name.isEmpty || manager.isEmpty) {
                        return;
                      }

                      final Gym model = Gym(
                          name: name,
                          email: email,
                          phone: int.tryParse(phone) ??
                              0, // Convert and handle potential parsing errors
                          address: address,
                          manager: manager,
                          id: gym?.id);
                      if (gym == null) {
                        await gymProvider.addGym(model);
                      } else {
                        await gymProvider.updateGym(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text(
                      gym == null ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
